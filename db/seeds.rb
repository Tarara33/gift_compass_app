require 'faker'

# User.create!(
#   name: "sarina",
#   email: "sa@com",
#   password: 'ssssss',
#   password_confirmation: 'ssssss'
# )

10.times do |x|
  User.create!(
                name: Faker::Name.name,
                email: Faker::Internet.email,
                password: '123456',
                password_confirmation: '123456'
  )
end

20.times do |x|
  tag_name = Faker::Games::Pokemon.name
  #既存のタグと重複しないかチェック
  unless Tag.exists?(tag_name: tag_name)
    Tag.create!(tag_name: tag_name)
  end
end

10.times do |x|
  item = Item.create!(
                item_name: Faker::Commerce.product_name,
                price: rand(0..30000),
                price_range: Item.price_ranges.keys.sample,
                target_gender: Item.target_genders.keys.sample,
                user_id: User.pluck(:id).sample
  )
  rand(1..5).times do
    tag = Tag.all.sample

    # itemとtagの組み合わせの重複を回避
    while item.tags.include?(tag)
      tag = Tag.all.sample
    end

    item.tags << tag
  end
end

10.times do |x|
  item = Item.create!(
                item_name: Faker::Commerce.product_name,
                price: rand(0..30000),
                price_range: Item.price_ranges.keys.sample,
                target_gender: Item.target_genders.keys.sample,
                user_id: 1
  )
  rand(1..5).times do
    tag = Tag.all.sample

    # itemとtagの組み合わせの重複を回避
    while item.tags.include?(tag)
      tag = Tag.all.sample
    end

    item.tags << tag
  end
end