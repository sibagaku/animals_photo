# frozen_string_literal: true

class Public::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :user_state, only:[:create]

  # ゲストログイン
  def guest_sign_in
    user = User.guest
    sign_in user
    redirect_to user_path(current_user.id)
  end

  def after_sign_in_path_for(resource)
    user_path(current_user.id)
  end



  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:email, :encrypted_password])
  end

  # 退会済みのユーザーアカウントからのログインを禁止する
  def user_state
#@user = User.find_by(email: params[:user][:email])
    @user = User.where('lower(email) = ?', params[:user][:email].downcase).first
    return if !@user
    if (@user.valid_password?(params[:user][:password])) && (@user.is_deleted == true)
      redirect_to root_path
    else

    end
  end



  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
