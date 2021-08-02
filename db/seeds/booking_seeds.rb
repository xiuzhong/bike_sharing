# Generate a random number of bookings for each bike - in either the past or future.
Bike.ids.each do |bike_id|
  rand(0...10).times do
    Booking.create(
      bike_id: bike_id,
      date: rand(-365..365).days.from_now.to_date,
      user_full_name: (0...8).map { (65 + rand(26)).chr }.join.downcase,
    )
  end
end
