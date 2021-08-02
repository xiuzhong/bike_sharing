class BookingsController < ApplicationController
  def new
    @booking ||= Booking.new(bike_id: booking_params[:bike_id])
  end

  def create
    @booking = CreateBooking.run(
      bike_id: booking_params[:bike_id],
      date: booking_params[:date],
      user_full_name: booking_params[:user_full_name],
    )

    if @booking.persisted?
      message = "Thanks for your booking #{@booking.user_full_name.capitalize}. See you on #{@booking.date.strftime('%A, %e %b')}!"
      respond_to do |format|
        format.json { render json: { success_message: message }, status: :created }
      end
    else
      errors = @booking.errors.full_messages
      respond_to do |format|
        format.json { render json: { error_messages: errors }, status: :unprocessable_entity }
      end
    end
  end

  private

  def booking_params
    params.permit(:bike_id, :date, :user_full_name)
  end
end
