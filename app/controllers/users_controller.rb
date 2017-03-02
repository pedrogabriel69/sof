class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: [:show, :change_daily_digest]

  skip_authorization_check

  def index
    @users = User.all
  end

  def show
  end

  def change_daily_digest
    @user.change_digest
  end

  private

  def set_user
    @user = User.find(params[:id])
  end
end
