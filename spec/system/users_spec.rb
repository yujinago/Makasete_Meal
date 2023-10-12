# frozen_string_literal: true

require 'rails_helper'
require 'support/test_helpers'

RSpec.describe Users, type: :system do
  before(:each) do
    FactoryBot.rewind_sequences
    @user = create(:user)
    login_as(@user, :scope => :user)
  end
  
  describe 'ゲストユーザーの場合' do
    let(:guest_user) { User.guest }

    before do
      login_as(guest_user, :scope => :user)
      visit users_mypage_path
    end
    it '編集するボタンが表示されないこと' do
      expect(page).not_to have_link('編集する', href: users_infomation_edit_path)
    end
    it 'ゲストユーザーがプロフィール編集画面へ遷移できないこと' do
      visit users_infomation_edit_path
      expect(page).to have_content('ゲストユーザーはプロフィール編集画面へ遷移できません。')
    end
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
        check_link('編集する', users_infomation_edit_path)
      end
      it '2つのお気に入りボタンの表示とURLを検証' do
        check_link('お気に入り', recipes_path(user_id: @user.id))
        check_link('お気に入り', restaurants_path(user_id: @user.id))
      end
      it '2つの一覧を見るボタンの表示とURLを検証' do
        check_link('一覧を見る', recipes_path)
        check_link('一覧を見る', restaurants_path)
      end
      it 'users_mypage_pathが"/users/mypage"であるか' do
        expect(current_path).to eq('/users/mypage')
      end
    end
  end
  
  describe 'ユーザー情報編集画面(users_infomation_edit_path)のテスト' do
    before do
      visit users_infomation_edit_path
    end
    context '表示の確認' do
      it '編集内容を保存ボタンの表示を検証' do
        check_button('編集内容を保存')
      end
      it '退会するボタンの表示とURLを検証' do
        check_link('退会する', users_confirm_path)
      end
      it 'users_infomation_edit_pathが"/users/infomation/edit"であるか' do
        expect(current_path).to eq('/users/infomation/edit')
      end
    end
    it '編集内容を保存ボタンがきちんと動作することの確認' do
      fill_in 'user[nickname]', with: '新しい名前'
      fill_in 'user[email]', with: 'new@example.com'
      click_button '編集内容を保存'
      expect(current_path).to eq(users_mypage_path)
      expect(page).to have_content('新しい名前')
      expect(page).to have_content('new@example.com') 
    end
    context '無効なデータの送信' do
      it '空のフィールドがエラーとなること' do
        fill_in 'user[nickname]', with: ''
        fill_in 'user[email]', with: ''
        click_button '編集内容を保存'
        expect(page).to have_content('エラーが発生しました')
        expect(page).to have_content('ニックネームを入力してください')
        expect(page).to have_content('Eメールを入力してください')
      end
      it '無効なメールアドレスがエラーとなること' do
        fill_in 'user[email]', with: 'invalid_email'
        click_button '編集内容を保存'
        expect(page).to have_content('エラーが発生しました')
        expect(page).to have_content('Eメールは不正な値です')
      end
    end
  end
  
  describe 'ユーザー退会確認画面(users_confirm_path)のテスト' do
    before do
      visit users_confirm_path
    end
    context '表示の確認' do
      it '退会しないボタンの表示とURLを検証' do
        check_link('退会しない', users_mypage_path)
      end
      it '退会するボタンの表示とURLを検証' do
        check_link('退会する', users_infomation_path)
      end
      it 'users_confirm_pathが"/users/confirm"であるか' do
        expect(current_path).to eq('/users/confirm')
      end
    end
    it '退会するボタンがきちんと動作することの確認' do
      click_link '退会する'
      expect(current_path).to eq(root_path)
      expect(page).to have_content('退会処理を実行しました。')
      
      visit new_user_session_path
      fill_in 'user[email]', with: @user.email
      fill_in 'user[password]', with: @user.password
      click_button 'ログイン', class: "btn btn-outline-info"
      expect(page).to have_content('Eメールまたはパスワードが違います。')
    
      expect(User.count).to eq(0)
    end
  end
  
end