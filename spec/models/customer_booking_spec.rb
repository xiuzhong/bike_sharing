require 'rails_helper'

RSpec.describe CustomerBooking, type: :model do
  it "allows bookings in the future" do
    future_booking = Booking.new(date: Date.tomorrow)
    future_booking.valid?

    expect(future_booking.errors[:date]).to be_empty
  end

  it "validates that the date is not in the past" do
    past_booking = CustomerBooking.new(date: Date.yesterday)
    past_booking.valid?

    expect(past_booking.errors[:date]).to include("can't be in the past")
  end

  it "allows bookings todays" do
    today = Booking.new(date: Date.today)
    today.valid?

    expect(today.errors[:date]).to be_empty
  end
end
