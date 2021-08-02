require 'rails_helper'

RSpec.describe BikeSearch do
  let(:alpha) { FactoryBot.create(:bike, name: 'alpha', price_per_day: 10) }
  let(:beta) { FactoryBot.create(:bike, name: 'beta', price_per_day: 7) }

  before do
    # alpha has no active booking, but three cancelled booking
    3.times do |i|
      FactoryBot.create(:customer_booking, bike: alpha, date: Date.today + i, status: :cancelled)
    end
    # beta has two active bookings and one owner booking
    2.times { |i| FactoryBot.create(:customer_booking, bike: beta, date: Date.today + i) }
    FactoryBot.create(:owner_booking, bike: beta, date: Date.today + 5)
  end

  subject(:bikes) { described_class.run }

  it "returns bikes correctly" do
    expect(bikes).to include(
      hash_including(
        id: alpha.id,
        name: 'alpha',
        price_per_day: alpha.price_per_day,
        popularity: 0
      ),
      hash_including(
        id: beta.id,
        name: 'beta',
        price_per_day: beta.price_per_day,
        popularity: 2
      )
    )
  end
end
