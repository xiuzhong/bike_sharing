class SearchController < ApplicationController
  def index
    @bikes = BikeSearch.run

    respond_to do |format|
      format.html
      format.json { render json: @bikes }
    end
  end
end
