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

  it "prevents a booking on the same date as an existing booking" do
    booking_date = 2.days.from_now
    bike = FactoryBot.create(:bike)
    conflicting_booking = FactoryBot.create(:booking, bike: bike, date: booking_date)

    booking = described_class.run(
      bike_id: bike.id,
      date: booking_date,
      user_full_name: 'Percy Winter',
    )

    expect(booking.errors.full_messages).to include("Date is not available for this bike")
  end
end
