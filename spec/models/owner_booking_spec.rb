require 'rails_helper'

RSpec.describe OwnerBooking, type: :model do
  it "allows booking in past" do
    past_booking = OwnerBooking.new(date: 2.days.ago)
    past_booking.valid?

    expect(past_booking.errors[:date]).to be_empty
  end

  it "validates default user_full_name" do
    owner_booking = OwnerBooking.new(date: Date.today)
    owner_booking.valid?

    expect(owner_booking.errors[:user_full_name]).to be_empty
  end
end
