FactoryBot.define do
  factory :notification do
    restaurant_id { 1 }
    content { "" }
    from_user_id { 2 }
    association :user
  end
end
