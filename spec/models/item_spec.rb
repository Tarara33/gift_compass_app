require 'rails_helper'

RSpec.describe Item, type: :model do
  user = 
  context '必須項目が入力されている場合' do
    it '有効である' do
      item = build(:item)
      expect(item).to be_valid
    end
  end

  context '商品名が未入力の場合' do
    it '無効である' do
      item = build(:item, item_name: nil)
      expect(item).to be_invalid
      expect(item.errors[:item_name]).to include('を入力してください')
    end
  end

  context '価格が未入力の場合' do
    it '無効である' do
      item = build(:item, price: nil)
      expect(item).to be_invalid
      expect(item.errors[:price]).to include('を入力してください')
    end
  end

  context '価格帯が未選択の場合' do
    it '無効である' do
      item = build(:item, price_range: nil)
      expect(item).to be_invalid
      expect(item.errors[:price_range]).to include('を選択してください')
    end
  end

  context '対象の性別が未入力の場合' do
    it '無効である' do
      item = build(:item, target_gender: nil)
      expect(item).to be_invalid
      expect(item.errors[:target_gender]).to include('を選択してください')
    end
  end
end
