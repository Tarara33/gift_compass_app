require 'rails_helper'

RSpec.describe User, type: :model do
  
  context 'すべてのフィールドが有効な場合' do
    it '有効であること' do
      user = build(:user)
      expect(user).to be_valid
    end
  end

  context '名前が空欄の場合' do
    it '無効であること' do
      user = build(:user, name: nil)
      expect(user).to be_invalid
      expect(user.errors[:name]).to include ('を入力してください')
    end
  end

  describe 'email' do
    context 'emailが空欄の場合' do
      it '無効であること' do
        user = build(:user, email: nil)
        expect(user).to be_invalid
        expect(user.errors[:email]).to include ('を入力してください')
      end
    end

    context 'emailが既に登録されている場合' do
      it '無効であること' do
        user = create(:user)
        others = build(:user, email: user.email)
        expect(others).to be_invalid
        expect(others.errors[:email]).to include ('はすでに存在します')
      end
    end
  end

  describe 'パスワード' do
    context 'passwordが空欄の場合' do
      it '無効であること' do
        user = build(:user, password: nil)
        expect(user).to be_invalid
        expect(user.errors[:password]).to include ('は6文字以上で入力してください')
      end
    end

    context 'passwordが6文字以下の場合' do
      it '無効であること' do
        user = build(:user, password: 'passw')
        expect(user).to be_invalid
        expect(user.errors[:password]).to include ('は6文字以上で入力してください')
      end
    end

    context 'passwordとpassword_confirmationが一致しない場合' do
      it '無効であること' do
        user = build(:user, password_confirmation: '12345678')
        expect(user).to be_invalid
        expect(user.errors[:password_confirmation]).to include ('とパスワードの入力が一致しません')
      end
    end
  end
end
