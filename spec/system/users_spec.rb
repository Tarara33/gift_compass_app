require 'rails_helper'

RSpec.describe "Users", type: :system do
  let(:user) {create(:user)}

  describe '成功' do
    context 'ユーザー登録フォームの入力が有効な場合' do
      it 'ユーザー登録に成功する' do
        visit new_user_path
        fill_in 'user[name]', with: 'テスト'
        fill_in 'user[email]', with: 'test@example.com'
        fill_in 'user[password]', with: '123456'
        fill_in 'user[password_confirmation]', with: '123456'
        click_button '登録する'
        expect(page).to have_content('ユーザー登録に成功しました')
        expect(current_path).to eq(items_path)
      end
    end
  end

  describe '失敗' do
    context '名前欄が空の場合' do
      it 'ユーザー登録に失敗する' do
        visit new_user_path
        fill_in 'user[name]', with: nil
        fill_in 'user[email]', with: 'test@example.com'
        fill_in 'user[password]', with: '123456'
        fill_in 'user[password_confirmation]', with: '123456'
        click_button '登録する'
        expect(page).to have_content('ユーザー登録に失敗しました')
        expect(current_path).to eq(new_user_path)
      end
    end

    context 'メールアドレス欄が空の場合' do
      it 'ユーザー登録に失敗する' do
        visit new_user_path
        fill_in 'user[name]', with: 'テスト'
        fill_in 'user[email]', with: nil
        fill_in 'user[password]', with: '123456'
        fill_in 'user[password_confirmation]', with: '123456'
        click_button '登録する'
        expect(page).to have_content('ユーザー登録に失敗しました')
        expect(current_path).to eq(new_user_path)
      end
    end

    context 'メールアドレスが既に存在する場合' do
      it 'ユーザー登録に失敗する' do
        visit new_user_path
        fill_in 'user[name]', with: 'テスト'
        fill_in 'user[email]', with: user.email
        fill_in 'user[password]', with: '123456'
        fill_in 'user[password_confirmation]', with: '123456'
        click_button '登録する'
        expect(page).to have_content('ユーザー登録に失敗しました')
        expect(current_path).to eq(new_user_path)
      end
    end

    context 'パスワードが空の場合' do
      it 'ユーザー登録に失敗する' do
        visit new_user_path
        fill_in 'user[name]', with: 'テスト'
        fill_in 'user[email]', with: 'test@example'
        fill_in 'user[password]', with: nil
        fill_in 'user[password_confirmation]', with: '123456'
        click_button '登録する'
        expect(page).to have_content('ユーザー登録に失敗しました')
        expect(current_path).to eq(new_user_path)
      end
    end

    context 'パスワード(確認)が空の場合' do
      it 'ユーザー登録に失敗する' do
        visit new_user_path
        fill_in 'user[name]', with: 'テスト'
        fill_in 'user[email]', with: 'test@example'
        fill_in 'user[password]', with: '123456'
        fill_in 'user[password_confirmation]', with: nil
        click_button '登録する'
        expect(page).to have_content('ユーザー登録に失敗しました')
        expect(current_path).to eq(new_user_path)
      end
    end

    context 'パスワード(確認)がパスワードと違う場合' do
      it 'ユーザー登録に失敗する' do
        visit new_user_path
        fill_in 'user[name]', with: 'テスト'
        fill_in 'user[email]', with: 'test@example'
        fill_in 'user[password]', with: '123456'
        fill_in 'user[password_confirmation]', with: '678910'
        click_button '登録する'
        expect(page).to have_content('ユーザー登録に失敗しました')
        expect(current_path).to eq(new_user_path)
      end
    end
  end
end
