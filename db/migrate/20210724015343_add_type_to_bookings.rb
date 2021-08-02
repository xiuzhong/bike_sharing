class AddTypeToBookings < ActiveRecord::Migration[6.1]
  def up
    add_column :bookings, :type, :string
    add_index :bookings, :type
    set_existing_bookings_type
  end

  def down
    remove_column :bookings, :type
  end

  def set_existing_bookings_type
    Booking.update(type: 'CustomerBooking')
  end
end
