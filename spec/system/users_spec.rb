# frozen_string_literal: true

require 'rails_helper'
require 'support/test_helpers'

RSpec.describe Users, type: :system do
  before(:each) do
    FactoryBot.rewind_sequences
    @user = create(:user)
    login_as(@user, :scope => :user)
  end
  
  describe 'ユーザー詳細画面(users_mypage_path)のテスト' do
    before do
      visit users_mypage_path
    end
    context '表示の確認' do
      it 'ニックネームが表示されているか' do
        expect(page).to have_content 'test_user'
      end
      it 'メールアドレスが表示されているか' do
        expect(page).to have_content 'test1@example.com'
      end
      it '登録情報の編集するボタンの表示とURLを検証' do
        check_button('編集する', users_infomation_edit_path)
      end
      it '2つのお気に入りボタンの表示とURLを検証' do
        check_button('お気に入り', recipes_path(user_id: @user.id))
        check_button('お気に入り', restaurants_path(user_id: @user.id))
      end
      it '2つの一覧を見るボタンの表示とURLを検証' do
        check_button('一覧を見る', recipes_path)
        check_button('一覧を見る', restaurants_path)
      end
      it 'users_mypage_pathが"/users/mypage"であるか' do
        expect(current_path).to eq('/users/mypage')
      end
    end
  end
  
end