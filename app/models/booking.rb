class Booking < ApplicationRecord
  belongs_to :bike

  validates :date, :user_full_name, presence: true
  validate :today_or_in_future

  scope :on_date, ->(query_date) { where(date: query_date) }

  def today_or_in_future
    if date < Date.current
      errors.add(:date, "can't be in the past")
    end
  end
end
