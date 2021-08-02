class Booking < ApplicationRecord; end
class CustomerBooking < Booking; end
class OwnerBooking < Booking
  # see TODO in owner_booking.rb
  DEFAULT_OWNER = '__DEFAULT_OWNER__'
end

class ImportBikeUnavailablityToOwnerBookings < ActiveRecord::Migration[6.1]
  FILE = Rails.root.join('db', 'seeds', 'bike_unavailable_dates').to_s
  def up
    Rails.logger.info("Importing bike unavailability from file: #{FILE}")

    load_unavailable_dates(File.readlines(FILE)).each do |bike_name, dates|
      bike = Bike.find_by!(name: bike_name)

      # 1: cancel all conflict bookings
      Booking.where(bike_id: bike.id, date: dates).update(status: 1)
      dates.uniq.each do |date|
        OwnerBooking.create!(bike: bike, date: date, user_full_name: OwnerBooking::DEFAULT_OWNER)
      end

      Rails.logger.info(
        "Import #{OwnerBooking.where(bike: bike).count} unavailabilities of bike: #{bike_name}"
      )
    end
    Rails.logger.info("Importing bike unavailability finished!")
  end

  def down
    OwnerBooking.delete_all
    # rollback to active
    Booking.update(status: 0)
  end

  private

  def valid_date?(date)
    DateTime.strptime(date, '%Y-%m-%d')
    true
  rescue ArgumentError
    false
  end

  def load_unavailable_dates(lines)
    dates = lines.each_with_object([]) do |line, array|
      line.strip!
      next if line.blank?

      if valid_date?(line)
        array.last << line
      else
        array << line.chomp(':')
        array << []
      end
    end

    Hash[*dates]
  end
end
