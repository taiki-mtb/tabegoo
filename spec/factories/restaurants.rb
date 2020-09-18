FactoryBot.define do
  factory :restaurant do
    name { "レストラン" }
    description { "オススメのレストランです" }
    category_id { 1 }
    created_at { Time.current }
    association :category
    city_address { "浅草一丁目" }
  end
  trait :yesterday do
    created_at { 1.day.ago }
  end

  trait :one_week_ago do
    created_at { 1.week.ago }
  end

  trait :one_month_ago do
    created_at { 1.month.ago }
  end

  trait :picture do
    picture {
      Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/fixtures/test_restaurant.jpg'))
    }
  end
end
