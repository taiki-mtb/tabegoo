FactoryBot.define do
  factory :restaurant do
    name { "レストラン" }
    description { "オススメのレストランです" }
    association :user
  end
end
