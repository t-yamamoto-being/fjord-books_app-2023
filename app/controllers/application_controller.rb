# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[postal_code address introduction])
    devise_parameter_sanitizer.permit(:account_update, keys: %i[postal_code address introduction])
  end

  def after_sign_out_path_for(_resource_or_scope)
    new_user_session_path
  end
end
