require 'rails_helper'

RSpec.describe "Items", type: :system do
  let(:user) { create(:user) }
  let(:item) { create(:item, user: user) }
  let(:other_item) { create(:item) }

  describe 'item(欲しいもの)CRUD' do
    describe '欲しいもの一覧(indexアクション)' do
      context 'ログイン前' do
        it 'topページの「探しに行く」から飛べること' do
          visit root_path
          click_link '探しに行く'
          expect(page).to have_current_path(items_path)
        end

        it 'topページの「ゲストで探しに行ってみる!」から飛べること' do
          visit root_path
          page.scroll_to :bottom
          # スクロール時間を待つ
          page.has_selector?('ゲストで探しに行ってみる', wait: 2)
          click_link 'ゲストで探しに行ってみる'
          expect(page).to have_current_path(items_path)
        end
      end

      context 'ログイン後' do
        it 'ヘッダーの「みんなの欲しいもの」から飛べること' do
          login(user)
          click_link '欲しいもの'
          click_link 'みんなの欲しいもの'
          expect(page).to have_current_path(items_path)
        end
      end

      context '欲しいものが一件もない場合' do
        it 'まだ欲しいものたちが登録されてませんというメッセージがある' do
          visit items_path
          expect(page).to have_content('まだ欲しいものたちが登録されていません')
        end
      end

      context '欲しいものが一つ以上登録されてる場合' do
        it '欲しいものたちが表示される' do
          item
          visit items_path
          expect(page).to have_content(item.item_name)
        end
      end
    end


    describe '欲しいもの詳細・編集・削除(showアクション/editアクション/destroyアクション)' do
      context 'ログイン前' do
        it '詳細は観れるが編集・削除ボタンなどがない' do
          visit item_path(item)
          expect(page).to have_content(item.item_name)
          expect(page).not_to have_selector("#button-edit-#{item.id}")
          expect(page).not_to have_selector("#button-delete-#{item.id}")
          expect(current_path).to eq(item_path(item))
        end
      end

      describe 'ログイン後' do
        before { login(user) }
        context '他人の詳細ページ' do
          it '編集ボタン・削除ボタンが表示されないこと' do
            visit item_path(other_item)
            expect(page).to have_current_path(item_path(other_item))
            expect(page).not_to have_selector("#button-edit-#{other_item.id}")
            expect(page).not_to have_selector("#button-delete-#{other_item.id}")
          end
        end

        context '自分の詳細ページ' do
          it '編集ボタン・削除ボタンが表示されること' do
            visit item_path(item)
            expect(page).to have_current_path(item_path(item))
            expect(page).to have_selector("#button-edit-#{item.id}")
            expect(page).to have_selector("#button-delete-#{item.id}")
          end

          it '編集ページに移動できること' do
            visit item_path(item)
            page.scroll_to :bottom
            # スクロール時間を待つ
            sleep(Capybara.default_max_wait_time)
            click_link(nil, href: edit_item_path(item))
            expect(page).to have_current_path(edit_item_path(item))
          end

          it '削除できること' do
            visit item_path(item)
            page.scroll_to :bottom
            # スクロール時間を待つ
            sleep(Capybara.default_max_wait_time)
            page.accept_confirm do
              click_link(nil, href: item_path(item))
            end
            expect(page).to have_current_path(items_path)
          end
        end
      end
    end


    describe '欲しいもの作成(newアクション/createアクション)' do
      context 'ログイン前' do
        it 'ログインページにリダイレクトされる' do
          visit new_item_path
          expect(page).to have_content('ログインしてください')
          expect(current_path).to eq(login_path)
        end
      end

      context 'ログイン後' do
        it '欲しいもの作成ページが見れる' do
          login(user)
          visit new_item_path
          expect(page).to have_current_path(new_item_path)
        end
      end

      context '必須項目が有効な場合' do
        before do
          login(user)
          visit new_item_path
        end

        it '欲しいものが登録できる(画像も投稿できる)' do
          fill_in 'item[item_name]', with: 'テスト'
          fill_in 'item[price]', with: 120
          select '0~1000円', from: 'item[price_range]'
          select 'みんなにオススメ', from: 'item[target_gender]'
          attach_file 'item[item_image]', "#{Rails.root}/spec/fixtures/images/test.jpeg"
          page.scroll_to :bottom
          # スクロール時間を待つ
          page.has_selector?('登録する', wait: 2)
          click_button '登録する'
          expect(page).to have_content('欲しいもの登録に成功しました')
          expect(current_path).to eq(item_path(Item.last.id))
          expect(page).to have_selector("img[src$= 'test.jpeg']")
        end
      end

      context '必須項目が足りない場合' do
        before do
          login(user)
          visit new_item_path
        end

        it '商品名が空で登録できない' do
          fill_in 'item[item_name]', with: nil
          fill_in 'item[price]', with: 120
          select '0~1000円', from: 'item[price_range]'
          select 'みんなにオススメ', from: 'item[target_gender]'
          page.scroll_to :bottom
          # スクロール時間を待つ
          page.has_selector?('登録する', wait: 2)
          click_button '登録する'
          expect(page).to have_content('欲しいもの登録に失敗しました')
          expect(current_path).to eq(new_item_path)
        end

        it '値段が空で登録できない' do
          fill_in 'item[item_name]', with: 'テスト'
          fill_in 'item[price]', with: nil
          select '0~1000円', from: 'item[price_range]'
          select 'みんなにオススメ', from: 'item[target_gender]'
          page.scroll_to :bottom
          # スクロール時間を待つ
          page.has_selector?('登録する', wait: 2)
          click_button '登録する'
          expect(page).to have_content('欲しいもの登録に失敗しました')
          expect(current_path).to eq(new_item_path)
        end

        it '値段が数値でないため登録できない' do
          fill_in 'item[item_name]', with: 'テスト'
          fill_in 'item[price]', with: 'あいう'
          select '0~1000円', from: 'item[price_range]'
          select 'みんなにオススメ', from: 'item[target_gender]'
          page.scroll_to :bottom
          # スクロール時間を待つ
          page.has_selector?('登録する', wait: 2)
          click_button '登録する'
          expect(page).to have_content('欲しいもの登録に失敗しました')
          expect(current_path).to eq(new_item_path)
        end

        it '価格帯が空で登録できない' do
          fill_in 'item[item_name]', with: 'テスト'
          fill_in 'item[price]', with: 120
          select 'みんなにオススメ', from: 'item[target_gender]'
          page.scroll_to :bottom
          # スクロール時間を待つ
          page.has_selector?('登録する', wait: 2)
          click_button '登録する'
          expect(page).to have_content('欲しいもの登録に失敗しました')
          expect(current_path).to eq(new_item_path)
        end

        it 'オススメ対象が空で登録できない' do
          fill_in 'item[item_name]', with: 'テスト'
          fill_in 'item[price]', with: 120
          select '0~1000円', from: 'item[price_range]'
          page.scroll_to :bottom
          # スクロール時間を待つ
          page.has_selector?('登録する', wait: 2)
          click_button '登録する'
          expect(page).to have_content('欲しいもの登録に失敗しました')
          expect(current_path).to eq(new_item_path)
        end
      end
    end
  end
end
