class BikesController < ApplicationController
  def show
    @bike = Bike.find(bike_params[:id])
  end

  private

  def bike_params
    params.permit(:id)
  end
end
