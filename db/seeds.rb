require 'faker'

10.times do |x|
  Item.create!(
                name: Faker::Games::Pokemon.name,
                price: rand(0..30000),
                price_range: Item.price_ranges.keys.sample,
                target_gender: Item.target_genders.keys.sample,
                user_id: 1
  )
end