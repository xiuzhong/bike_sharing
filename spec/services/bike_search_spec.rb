require 'rails_helper'

RSpec.describe BikeSearch do
  let(:alpha) { FactoryBot.create(:bike, name: 'alpha', price_per_day: 10) }
  let(:beta) { FactoryBot.create(:bike, name: 'beta', price_per_day: 7) }
  let(:delta) { FactoryBot.create(:bike, name: 'delta', price_per_day: 5) }

  before do
    # beta has three active bookings
    3.times { |i| FactoryBot.create(:customer_booking, bike: beta, date: Date.today + i) }
    # delta has zero active booking, but two owner booking
    2.times { |i| FactoryBot.create(:owner_booking, bike: delta, date: Date.today + i) }
    # alpha has one active booking, and three cancelled booking
    1.times { |i| FactoryBot.create(:customer_booking, bike: alpha, date: Date.today + i) }
    3.times do |i|
      FactoryBot.create(:customer_booking, bike: alpha, date: Date.today + i, status: :cancelled)
    end
  end

  it "sort on name by default" do
    expect(described_class.run.map(&:name)).to eq %w(alpha beta delta)
  end

  it "sort on name" do
    expect(described_class.run(sort_by: :name).map(&:name)).to eq %w(alpha beta delta)
  end

  it "sort on price" do
    expect(described_class.run(sort_by: :price).map(&:name)).to eq %w(delta beta alpha)
  end

  it "sort on popularity" do
    byebug
    expect(described_class.run(sort_by: :popularity).map(&:name)).to eq %w(beta alpha delta)
  end

  context 'when popularity increases' do
    before do
      3.times { |i| FactoryBot.create(:customer_booking, bike: alpha, date: 1.day.from_now + i) }
    end

    it "sort on popularity" do
      expect(described_class.run(sort_by: :popularity).map(&:name)).to eq %w(alpha beta delta)
    end
  end
end
