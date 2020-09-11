User.create!(name:  "マネージャー　まとば",
            email: "sample@example.com",
            password:              "foobar",
            password_confirmation: "foobar",
            admin: true)

49.times do |n|
 name  = Faker::Name.name
 email = "sample-#{n+1}@example.com"
 password = "password"
 User.create!(name:  name,
              email: email,
              password:              password,
              password_confirmation: password)
end

Category.create!(name: "居酒屋")

Restaurant.create!(name: "レストランexample",
               description: "冬に行きたい、身体が温まるレストランです",
               category_id: 1,
               association: category)
end
