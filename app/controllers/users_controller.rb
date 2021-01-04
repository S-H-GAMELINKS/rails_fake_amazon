class UsersController < ApplicationController
  before_action :set_user

  def edit
  end

  def update
    # update_without_passwordはgem deviseで使えるメソッドで定義不要。パスワードなしでユーザー情報を更新するメソッド。
    @user.update_without_password(user_params)
    redirect_to mypage_users_url
  end

  def mypage
  end

  def edit_address
  end

  def update_password
    if password_set?
      @user.update_password(user_params)
      flash[:notice] = "パスワードは正しく更新されました。"
      redirect_to root_url
    else
      @user.errors.add(:password, "パスワードに不備があります。")
      render 'edit_password'
    end
  end

  def edit_password
  end

  private

  def set_user
    @user = current_user
  end

  def user_params
    params.permit(:name, :email, :address, :phone, :password_confirmation)
  end

  def password_set?
    user.params[:password].present? && user_params[:password_confirmation].present? ?
    true : false
  end
end