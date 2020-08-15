FactoryBot.define do
  factory :comment do
    user_id { 1 }
    content { "料理も店員さんも最高でした。" }
    association :restuarant
  end
end
