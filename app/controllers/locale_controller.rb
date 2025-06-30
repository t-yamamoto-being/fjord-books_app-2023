# frozen_string_literal: true

class LocaleController < ApplicationController
  def change
    locale = params[:locale].to_s.strip.to_sym
    session[:locale] = locale if I18n.available_locales.include?(locale)
    redirect_back(fallback_location: root_path)
  end
end
