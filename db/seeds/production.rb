# ジャンル作成
genres = ["ファッション", "ファッション小物", "コスメ", "家電", "ホビー", "ゲーム", "雑貨",  "食品",  "健康", "ペット"]
genres.each do |genre_name|
  Genre.create!(name: genre_name)
end

# シチュエーション作成
situations = ["誕生日", "ふとした日のプレゼント", "クリスマス", "バレンタイン", "ホワイトデー", "母の日", "父の日"]
situations.each do |situation_name|
  Situation.create!(name: situation_name)
end