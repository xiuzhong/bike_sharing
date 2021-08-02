class SearchController < ApplicationController
  def index
    # TODO: only get available bikes. Move to service
    @bikes = Bike.all

    respond_to do |format|
      format.html
      format.json { render json: @bikes }
    end
  end
end
