class Booking < ApplicationRecord
  validates :date, presence: true
  validates :user_full_name, presence: true
  scope :on_date, ->(query_date) { where(date: query_date) }
  enum status: { active: 0, cancelled: 1 }
  belongs_to :bike
  validates_uniqueness_of :bike_id,
    scope: [:date, :status],
    conditions: -> { where(status: :active) },
    message: 'is not available any longer'
end
