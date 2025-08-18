# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  before_action :authenticate_user!

  def update
    @user = current_user
    if @user.update_without_password(account_update_params)
      redirect_to profile_path, notice: t('devise.registrations.updated')
    else
      render :edit
    end
  end

  protected

  def after_update_path_for(_resource)
    profile_path
  end

  private

  def account_update_params
    params.require(:user).permit(:email, :postal_code, :address, :introduction)
  end
end
