require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  let(:user) { create(:user) } # FactoryGirlや FactoryBot を使用してユーザーオブジェクトを作成

  describe "GET #show" do
    it "returns http success" do
      sign_in user # ログイン状態にする
      get :show
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #edit" do
    it "returns http success" do
      sign_in user
      get :edit
      expect(response).to have_http_status(:success)
    end
  end
  
  describe "GET #confirm" do
    it "returns http success" do
      sign_in user
      get :confirm
      expect(response).to have_http_status(:success)
    end
  end

  describe "PATCH #update" do
    it "updates the user's information" do
      sign_in user
      new_nickname = "New Nickname"
      patch :update, params: { user: { nickname: new_nickname } }
      user.reload
      expect(user.nickname).to eq(new_nickname)
    end
  end

  describe "DELETE #destroy" do
    it "destroys the user account" do
      sign_in user
      expect { delete :destroy }.to change { User.count }.by(-1)
    end
  end
  
end