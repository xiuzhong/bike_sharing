FactoryBot.define do
  factory :booking do
    bike
    date { 2.days.from_now.to_date }
    sequence(:user_full_name) { |n| "user_full_name_#{n}" }
  end

  factory :customer_booking do
    bike
    date { 2.days.from_now.to_date }
    sequence(:user_full_name) { |n| "user_full_name_#{n}" }
  end

  factory :owner_booking do
    bike
    date { 4.days.from_now.to_date }
  end
end
