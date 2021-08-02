class CreateBooking < Service
  def initialize(bike_id:, date:, user_full_name:)
    @bike = Bike.find(bike_id)
    @date = date
    @user_full_name = user_full_name
  end

  def run
    @booking = CustomerBooking.create(
      bike_id: @bike.id,
      date: @date,
      user_full_name: @user_full_name,
    )
  rescue ActiveRecord::RecordNotUnique
    @booking.errors.add(:bike_id, 'is not available any longer')
  ensure
    @booking
  end
end
