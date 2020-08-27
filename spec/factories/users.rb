FactoryBot.define do
  factory :user do
    name { Faker::Name.name }
    sequence(:email) { |n| "example#{n}@example.com" }
    password { "foobar" }
    password_confirmation { "foobar" }
    sex { "男性" }
    uid {"1"}
    provider {"google"}
    trait :admin do
      admin { true }
    end
  end
end
