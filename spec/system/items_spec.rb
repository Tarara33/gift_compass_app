require 'rails_helper'

RSpec.describe "Items", type: :system do
  let(:user) { create(:user) }
  
  describe '成功' do
    context '必須項目が全て有効な場合' do
      it '欲しいものの登録に成功する' do
        visit new_item_path
        fill_in 'item[item_name]', with: 'テスト'
        fill_in 'item[price]', with: 1200
        select '0~1000円', from: 'item[price_range]'
        select 'みんなにオススメ', from: 'item[target_gender]'
        execute_script("document.querySelector('.fixed-bottom').style.display = 'none';")
        click_button '登録する'
        expect(page).to have_content('欲しいもの登録に成功しました')
        expect(current_path).to eq(item_path(Item.last.id))
      end
    end
  end
end
