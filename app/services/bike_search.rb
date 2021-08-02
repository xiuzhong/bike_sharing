class BikeSearch < Service
  def initialize(date: nil)
    @date = date
  end

  def run
    bikes_with_popularity.map do |bike|
      {
        id: bike.id,
        name: bike.name,
        image_name: bike.image_name,
        description: bike.description,
        price_per_day: bike.price_per_day,
        popularity: bike.popularity_count
      }
    end
  end

  private

  attr_reader :date

  POPULARITY_JOIN = %q(
    LEFT OUTER JOIN bookings popularity
    ON popularity.bike_id = bikes.id
    AND popularity.status = 0
    AND popularity.type = 'CustomerBooking'
  )
  def bikes_with_popularity
    Bike
      .joins(POPULARITY_JOIN)
      .distinct
      .select('bikes.*, COUNT(popularity.*) AS popularity_count')
      .group('bikes.id')
  end
end
