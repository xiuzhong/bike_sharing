class CustomerBooking < Booking
  validates :user_full_name, presence: true
  validate :today_or_in_future

  def today_or_in_future
    if date < Date.current
      errors.add(:date, "can't be in the past")
    end
  end
end
