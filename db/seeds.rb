require 'faker'

10.times do |x|
  User.create!(
                name: Faker::Games::Pokemon.name,
                email: Faker::Internet.email,
                password: '123456',
                password_confirmation: '123456'
  )
end

10.times do |x|
  Item.create!(
                item_name: Faker::Commerce.product_name,
                price: rand(0..30000),
                price_range: Item.price_ranges.keys.sample,
                target_gender: Item.target_genders.keys.sample,
                user_id: User.pluck(:id).sample
  )
end