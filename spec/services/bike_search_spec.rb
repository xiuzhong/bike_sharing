require 'rails_helper'

RSpec.describe BikeSearch do
  let(:today) { Date.parse('2021-10-06') }
  let(:alpha) { FactoryBot.create(:bike, name: 'alpha', price_per_day: 10) }
  let(:beta) { FactoryBot.create(:bike, name: 'beta', price_per_day: 7) }

  before do
    # alpha has no active booking, but three cancelled booking
    3.times do |i|
      FactoryBot.create(:customer_booking, bike: alpha, date: today + i, status: :cancelled)
    end
    # beta has two active bookings and one owner booking
    2.times { |i| FactoryBot.create(:customer_booking, bike: beta, date: today + i) }
    FactoryBot.create(:owner_booking, bike: beta, date: today + 5)
  end

  subject(:bikes) { described_class.run(date: date) }

  let(:expected_alpha) do
    {
      id: alpha.id,
      name: 'alpha',
      price_per_day: alpha.price_per_day,
      popularity: 0
    }
  end

  let(:expected_beta) do
    {
      id: beta.id,
      name: 'beta',
      price_per_day: beta.price_per_day,
      popularity: 2
    }
  end

  context 'no date param is given' do
    let(:date) { nil }

    it "returns bikes correctly" do
      expect(bikes).to contain_exactly(
        hash_including(expected_alpha),
        hash_including(expected_beta)
      )
    end
  end

  context 'date param is given' do
    context 'all bikes are available on the given date' do
      let(:date) { '2021-11-06' }

      it "returns bikes correctly" do
        expect(bikes).to contain_exactly(
          hash_including(expected_alpha),
          hash_including(expected_beta)
        )
      end
    end

    context 'bike beta is booked on the given date' do
      let(:date) { today }

      it "returns bikes correctly" do
        expect(bikes).to contain_exactly(
          hash_including(expected_alpha)
        )
      end
    end

    context 'bike beta is not available on the given date' do
      let(:date) { today + 5 }

      it "returns bikes correctly" do
        expect(bikes).to contain_exactly(
          hash_including(expected_alpha)
        )
      end
    end
  end

end
