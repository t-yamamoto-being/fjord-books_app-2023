# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: [:show]

  def index
    @users = User.order(:id)
  end

  def show
  end

  def profile
    @user = current_user
  end

  private

  def set_user
    @user = User.find(params[:id])
  end
end
