require 'rails_helper'

RSpec.describe Booking, type: :model do
  describe 'bike availablity' do
    before { another.valid? }

    context 'same bike and date' do
      subject(:another) { Booking.new(date: booking.date, bike: booking.bike ) }
      context 'an active booking exists' do
        let(:booking) { FactoryBot.create(:customer_booking) }

        it 'does not allow another booking' do
          expect(another.errors[:bike_id]).to include(/not available/)
        end
      end

      context 'a cancelled booking exists' do
        let!(:booking) { FactoryBot.create(:customer_booking, status: :cancelled) }

        it 'allow another booking' do
          expect(another.errors[:bike_id]).to be_empty
        end
      end

      context 'the bike is not available' do
        let(:booking) { FactoryBot.create(:owner_booking) }

        it 'does not allow a booking' do
          expect(another.errors[:bike_id]).to include(/not available/)
        end
      end
    end

    context 'different bike on the same date' do
      subject(:another) { Booking.new(date: booking.date ) }

      context 'an active booking exists' do
        let(:booking) { FactoryBot.create(:customer_booking) }

        it 'allow booking' do
          expect(another.errors[:bike_id]).to be_empty
        end
      end
    end

    context 'the same bike on different date' do
      subject(:another) { Booking.new(bike: booking.bike, date: 30.days.from_now.to_date ) }

      context 'an active booking exists' do
        let(:booking) { FactoryBot.create(:customer_booking) }

        it 'allow booking' do
          expect(another.errors[:bike_id]).to be_empty
        end
      end
    end
  end
end
