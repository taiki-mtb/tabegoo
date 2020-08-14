FactoryBot.define do
  factory :favorite do
    association :restaurant
    association :user
  end
end
