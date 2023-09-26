class UsersController < ApplicationController
  before_action :ensure_guest_user, only: [:edit, :confirm]
  
  def show
    @user = current_user
  end

  def edit
    @user = current_user
  end

  def confirm
  end
  
  def update
    @user = current_user
    if @user.update(user_params)
      flash[:notice] = "登録情報を変更しました。"
      redirect_to users_mypage_path
    else
      render :edit
    end
  end
  
  def destroy
    user = current_user
    user.destroy
    if user.guest_user?
      flash[:notice] = "ゲストユーザーでログアウトしました。"
    else
      flash[:notice] = "退会処理を実行しました。"
    end
    
    redirect_to root_path
  end
  
  private

  def user_params
    params.require(:user).permit(:nickname, :email)
  end
  
  def ensure_guest_user
    user = current_user
    if user.guest_user?
      flash[:alert] = "ゲストユーザーはプロフィール編集画面へ遷移できません。"
      redirect_to root_path
    end
  end  
  
end
