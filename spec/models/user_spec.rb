# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'バリデーション' do
    it '有効な属性であること' do
      user = build(:user)
      expect(user).to be_valid
    end

    it 'ニックネームがない場合は無効であること' do
      user = build(:user, nickname: nil)
      expect(user).not_to be_valid
      expect(user.errors[:nickname]).to include('を入力してください')
    end

    it '10文字より長いニックネームは無効であること' do
      user = build(:user, nickname: 'a' * 11)
      expect(user).not_to be_valid
      expect(user.errors[:nickname]).to include('は10文字以内で入力してください')
    end

    it 'メールアドレスがない場合は無効であること' do
      user = build(:user, email: nil)
      expect(user).not_to be_valid
      expect(user.errors[:email]).to include('を入力してください')
    end
    
    it '重複したメールアドレスは無効であること' do
      create(:user, email: 'test@example.com')
      user = build(:user, email: 'test@example.com')
      expect(user).not_to be_valid
      expect(user.errors[:email]).to include('はすでに存在します')
    end
  end

  describe 'カスタムメソッド' do
    context 'ゲストユーザーの生成' do
      it 'ゲストユーザーを作成できること' do
        guest_user = User.guest
        expect(guest_user).to be_valid
        expect(guest_user.guest_user?).to be(true)
      end
      it '異なるゲストユーザーが生成されること' do
        guest_user1 = User.guest
        guest_user2 = User.guest
  
        expect(guest_user1.email).not_to eq(guest_user2.email)
        expect(guest_user1.password).not_to eq(guest_user2.password)
        expect(guest_user1.nickname).to eq(guest_user2.nickname)
      end
    end
  end
  
end