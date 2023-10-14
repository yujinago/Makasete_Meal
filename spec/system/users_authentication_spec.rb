# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'ユーザー認証', type: :system do
  before(:each) do
    FactoryBot.rewind_sequences
    @user = create(:user)
  end

  describe 'ログイン' do
    it 'ユーザーがログインできること' do
      visit new_user_session_path
      fill_in 'user[email]', with: @user.email
      fill_in 'user[password]', with: @user.password
      click_button 'ログイン', class: "btn btn-outline-info"
      expect(page).to have_content('ログインしました。')
    end
  
    it '誤った情報を持つユーザーがログインできないこと' do
      visit new_user_session_path
      fill_in 'user[email]', with: @user.email
      fill_in 'user[password]', with: 'differentpassword'
      click_button 'ログイン', class: "btn btn-outline-info"
      expect(page).to have_content('Eメールまたはパスワードが違います。')
    end
  end
  
  describe 'ログアウト' do
    it 'ユーザーがログアウトできること' do
      login_as(@user, :scope => :user)
      visit root_path
      click_link 'ログアウト'
      expect(page).to have_content('ログアウトしました。')
    end
  end
  
  describe 'ゲストユーザー' do
    it 'ゲストユーザーがログインできること' do
      visit root_path
      click_link 'ゲストログイン'
      expect(page).to have_content('ゲストユーザーでログインしました。')
    end
  
    it 'ゲストユーザーがログアウトできること' do
      visit root_path
      click_link 'ゲストログイン'
      click_link 'ログアウト'
      expect(page).to have_content('ゲストユーザーでログアウトしました。')
    end
    
    it '同じゲストユーザーのアカウントで再度ログインできないこと' do
      guest_user = User.guest
      login_as(guest_user, :scope => :user)
      visit root_path
      click_link 'ログアウト'
      visit new_user_session_path
      fill_in 'user[email]', with: guest_user.email
      fill_in 'user[password]', with: guest_user.password
      click_button 'ログイン', class: "btn btn-outline-info"
      expect(page).to have_content('Eメールまたはパスワードが違います。')
    end
  end
  
end