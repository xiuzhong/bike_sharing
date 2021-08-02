FactoryBot.define do
  factory :booking do
    bike
    date { 2.days.from_now.to_date }
    user_full_name { "Fran Dunkin" }
  end
end
