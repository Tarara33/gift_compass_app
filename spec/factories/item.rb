FactoryBot.define do
  factory :item do
    sequence(:name) {|n| "アイテム#{n}" }
    price { 1000 }
    price_range { :upto_1000 }
    target_gender { :other }
    association user
  end
end