class SearchController < ApplicationController
  def index
    @bikes = BikeSearch.run(date: available_on_param)

    respond_to do |format|
      format.html
      format.json { render json: @bikes }
    end
  end

  private

  def available_on_param
    DateTime.strptime(params['date'].to_s, '%Y-%m-%d').to_date.to_s
  rescue ArgumentError
    nil
  end
end
