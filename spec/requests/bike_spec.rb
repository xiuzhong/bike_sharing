require 'rails_helper'

RSpec.describe "Bikes", type: :request do
  describe "GET /index" do
    it "returns http success" do
      bike = FactoryBot.create(:bike)
      get "/bikes/#{bike.id}"
      expect(response).to have_http_status(:success)
    end
  end
end
