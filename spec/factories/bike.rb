FactoryBot.define do
  factory :bike do
    sequence(:name) { |n| "bike_#{n}" }
    description { "Some description" }
    image_name { name }
    price_per_day { 13.65 }
  end
end
