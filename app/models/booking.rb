class Booking < ApplicationRecord
  belongs_to :bike
  validates :date, presence: true
  scope :on_date, ->(query_date) { where(date: query_date) }
end
