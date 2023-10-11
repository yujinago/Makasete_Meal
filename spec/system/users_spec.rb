# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  let(:user) { create(:user) } # FactoryGirlや FactoryBot を使用してユーザーオブジェクトを作成
  
  describe 'ユーザー詳細画面(users_mypage_path)のテスト' do
    before do
      sign_in user
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
        edit_button = find_button('編集する')
        expect(edit_button).to be_present
        button_url = edit_button['data-url']
        expect(button_url).to eq(users_infomation_edit_path)
      end
      it '2つのお気に入りボタンの表示とURLを検証' do
        favorite_buttons = all('button', text: 'お気に入り')
        expect(favorite_buttons).not_to be_empty
        favorite_buttons.each do |button|
          button_url = button['data-url']
          expect(button_url).to eq(recipes_path(user))
          expect(button_url).to eq(restaurants_path(user))
        end
      end
      it '2つの一覧を見るボタンの表示とURLを検証' do
        favorite_buttons = all('button', text: '一覧を見る')
        expect(favorite_buttons).not_to be_empty
        favorite_buttons.each do |button|
          button_url = button['data-url']
          expect(button_url).to eq(recipes_path)
          expect(button_url).to eq(restaurants_path)
        end
      end
      it 'users_mypage_pathが"/users/mypage"であるか' do
        expect(current_path).to eq('/users/mypage')
      end
    end
  end
  
  
end