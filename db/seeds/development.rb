require 'faker'

# 自分を作成
# User.create!(
#   name: "sarina",
#   email: "sa@com",
#   password: 'ssssss',
#   password_confirmation: 'ssssss'
# )

# ジャンルを作成
genres = ["ファッション", "ファッション小物", "コスメ", "家電", "ホビー", "ゲーム", "雑貨",  "食品",  "健康", "ペット"]
genres.each do |genre_name|
  Genre.create!(name: genre_name)
end

# シチュエーションを作成
situations = ["誕生日", "ふとした日のプレゼント", "クリスマス", "バレンタイン", "ホワイトデー", "母の日", "父の日"]
situations.each do |situation_name|
  Situation.create!(name: situation_name)
end

# ユーザーを作る
10.times do |x|
  User.create!(
                name: Faker::Name.name,
                email: Faker::Internet.email,
                password: '123456',
                password_confirmation: '123456'
  )
end

# タグを作る
20.times do |x|
  tag_name = Faker::Games::Pokemon.name
  #既存のタグと重複しないかチェック
  unless Tag.exists?(tag_name: tag_name)
    Tag.create!(tag_name: tag_name)
  end
end

# アイテムを作る
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


# シチュエーション × ジャンル × 価格帯の組み合わせ作成
# ジャンルを作成
genres = Genre.all
# シチュエーションを作成
situations = Situation.all
# 価格帯を指定
price_ranges = Item.price_ranges.keys

# ジャンルとシチュエーション、価格帯の組み合わせで Item を作成
situations.each do |situation|
  genres.each do |genre|
    price_ranges.each do |price_range|
      Item.create!(
        item_name: "#{situation.name} #{genre.name} #{price_ranges.index(price_range) + 1}",
        price: rand(1000..5000),  # 仮の価格の範囲を指定
        price_range: price_range,
        target_gender: rand(0..2),
        genre: genre,
        situation: situation,
        user_id: 1
      )
    end
  end
end
