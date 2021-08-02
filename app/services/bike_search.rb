class BikeSearch < Service
  def initialize(sort_by: :name, date: nil)
    @sort_by = sort_by
    @date = date
  end

  def run
    query = Bike.all

    case sort_by
    when :price
      query.order(:price_per_day)
    when :popularity
      sort_on_popularity(query)
    else
      query.order(:name)
    end
  end

  private

  attr_reader :sort_by, :date

  POPULARITY_JOIN = %q(
    LEFT OUTER JOIN bookings popularity
    ON popularity.bike_id = bikes.id
    AND popularity.status = 0
    AND popularity.type = 'CustomerBooking'
  )
  def sort_on_popularity(query)
    query
      .joins(POPULARITY_JOIN)
      .distinct
      .select('bikes.*, COUNT(popularity.*) AS popularity_count')
      .group('bikes.id')
      .order('popularity_count DESC')
  end
end
