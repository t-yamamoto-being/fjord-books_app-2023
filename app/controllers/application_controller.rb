# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :set_locale

  def change_locale
    locale = params[:locale].to_s.strip.to_sym
    session[:locale] = locale if I18n.available_locales.include?(locale)
    redirect_back(fallback_location: root_path)
  end

  private

  def set_locale
    I18n.locale = session[:locale] || I18n.default_locale
  end
end
