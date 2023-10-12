# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  let(:user) { create(:user) }

  describe 'GET #show' do
    context 'ユーザーがログインしていない場合' do
      it 'リダイレクトされること' do
        get :show
        expect(response).to have_http_status(:redirect)
        expect(response).to redirect_to(new_user_session_path)
      end
    end
    context 'ユーザーがログインしている場合' do
      it 'HTTPステータスが成功（200 OK）を返すこと' do
        sign_in user
        get :show
        expect(response).to have_http_status(:success)
      end
    end
  end

  describe 'GET #edit' do
    context 'ユーザーがログインしていない場合' do
      it 'リダイレクトされること' do
        get :edit
        expect(response).to have_http_status(:redirect)
        expect(response).to redirect_to(new_user_session_path)
      end
    end
    context 'ユーザーがログインしている場合' do
      it 'HTTPステータスが成功（200 OK）を返すこと' do
        sign_in user
        get :edit
        expect(response).to have_http_status(:success)
      end
    end
  end
  
  describe 'GET #confirm' do
    context 'ユーザーがログインしていない場合' do
      it 'リダイレクトされること' do
        get :confirm
        expect(response).to have_http_status(:redirect)
        expect(response).to redirect_to(new_user_session_path)
      end
    end
    context 'ユーザーがログインしている場合' do
      it 'HTTPステータスが成功（200 OK）を返すこと' do
        sign_in user
        get :confirm
        expect(response).to have_http_status(:success)
      end
    end
  end

  describe 'PATCH #update' do
    context 'ユーザーがログインしていない場合' do
      it 'ユーザー情報が更新されないこと' do
        new_nickname = '新しい名前'
        patch :update, params: { user: { nickname: new_nickname } }
        user.reload
        expect(user.nickname).not_to eq(new_nickname)
      end
    end
    context 'ユーザーがログインしている場合' do
      it 'ユーザー情報が更新されること' do
        sign_in user
        new_nickname = '新しい名前'
        patch :update, params: { user: { nickname: new_nickname } }
        user.reload
        expect(user.nickname).to eq(new_nickname)
        expect(response).to redirect_to(users_mypage_path)
        expect(flash[:notice]).to eq('登録情報を変更しました。')
      end
      it '無効なデータで更新できないこと' do
        sign_in user
        new_nickname = ''
        patch :update, params: { user: { nickname: new_nickname } }
        user.reload
        expect(user.nickname).not_to eq(new_nickname)
      end
    end
  end

  describe 'DELETE #destroy' do
    context 'ユーザーがログインしていない場合' do
      it 'ユーザーアカウントが削除されないこと' do
        expect { delete :destroy }.not_to change { User.count }
      end
    end
    context 'ユーザーがログインしている場合' do
      it 'ユーザーアカウントが削除されること' do
        sign_in user
        expect { delete :destroy }.to change { User.count }.by(-1)
        expect(flash[:notice]).to eq('退会処理を実行しました。')
      end
    end
  end
  
end