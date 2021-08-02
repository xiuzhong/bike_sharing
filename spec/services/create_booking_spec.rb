require 'rails_helper'

RSpec.describe CreateBooking do
  it "creates and persists a booking" do
    bike = FactoryBot.create(:bike)

    params = {
      bike_id: bike.id,
      date: Date.current + 2.days,
      user_full_name: 'Percy Winter',
    }

    expect { described_class.run(params) }.to change(Booking, :count).by(1)
  end

  it "returns the booking" do
    bike = FactoryBot.create(:bike)

    params = {
      bike_id: bike.id,
      date: Date.current + 2.days,
      user_full_name: 'Percy Winter',
    }

    result = described_class.run(params)
    expect(result).to be_a Booking
  end

  it "prevents a booking without a full user name" do
    booking_date = 2.days.from_now
    bike = FactoryBot.create(:bike)

    booking = described_class.run(
      bike_id: bike.id,
      date: booking_date,
      user_full_name: '',
    )

    expect(booking.errors.full_messages).to include(/can't be blank/)
  end

  it "prevents a booking on the same date as an existing booking" do
    booking_date = 2.days.from_now
    bike = FactoryBot.create(:bike)
    conflicting_booking = FactoryBot.create(:customer_booking, bike: bike, date: booking_date)

    booking = described_class.run(
      bike_id: bike.id,
      date: booking_date,
      user_full_name: 'Percy Winter',
    )

    expect(booking.errors.full_messages).to include(/Bike is not available/)
  end

  it "prevents a booking on the day when the bike is not available" do
    booking_date = 2.days.from_now
    bike = FactoryBot.create(:bike)
    unavailable = FactoryBot.create(:owner_booking, bike: bike, date: booking_date)

    booking = described_class.run(
      bike_id: bike.id,
      date: booking_date,
      user_full_name: 'Percy Winter',
    )

    expect(booking.errors.full_messages).to include(/Bike is not available/)
  end
end
