class SearchController < ApplicationController
  def index
    @bikes = BikeSearch.run(sort_by: sort_by_param)

    respond_to do |format|
      format.html
      format.json { render json: @bikes }
    end
  end

  private

  def sort_by_param
    :name
  end
end
