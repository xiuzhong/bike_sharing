require 'rails_helper'

RSpec.describe "Bookings", type: :request do
  describe "GET /new" do
    it "returns http success" do
      bike = FactoryBot.create(:bike)
      get "/bikes/#{bike.id}/booking/new"
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST /create" do
    it "invokes the CreateBooking service" do
      bike = FactoryBot.create(:bike)
      booking_params = {
        bike_id: bike.id.to_s,
        user_full_name: "User 1",
        date: 2.days.from_now.strftime("%F"),
      }
      booking = FactoryBot.build_stubbed(:booking)
      allow(CreateBooking).to receive(:run).and_return(booking)

      post "/bikes/#{bike.id}/booking", xhr: true, params: booking_params

      expect(CreateBooking).to have_received(:run).with(booking_params)
    end

    it "responds with 201 when successfully created" do
      bike = FactoryBot.create(:bike)
      booking_params = {
        bike_id: bike.id.to_s,
        user_full_name: "User 1",
        date: 2.days.from_now.strftime("%F"),
      }
      booking = FactoryBot.build_stubbed(:booking)
      allow(CreateBooking).to receive(:run).and_return(booking)

      post "/bikes/#{bike.id}/booking", xhr: true, params: booking_params

      expect(response).to have_http_status(:created)
      expect(response.body).to include("Thanks for your booking")
    end

    it "responds with 422 when booking is unsuccessful" do
      bike = FactoryBot.create(:bike)
      booking_params = {
        bike_id: bike.id.to_s,
        user_full_name: "User 1",
        date: 2.days.from_now.strftime("%F"),
      }
      booking = FactoryBot.build(:booking)
      allow(CreateBooking).to receive(:run).and_return(booking)

      post "/bikes/#{bike.id}/booking", xhr: true, params: booking_params

      expect(response).to have_http_status(:unprocessable_entity)
    end
  end
end
