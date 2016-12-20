class Api::V1::ProfilesController < ApplicationController
  before_action :doorkeeper_authorize!
  skip_authorization_check

  respond_to :json

  def me
    respond_with current_resourse_owner
  end

  def index
    @users = users_except_current
    respond_with @users
  end

  private

  def users_except_current
    doorkeeper_token.present? ? User.where.not(id: current_resourse_owner.id) : User.all
  end

  protected

  def current_resourse_owner
    @current_resourse_owner ||= User.find(doorkeeper_token.resource_owner_id) if doorkeeper_token
  end
end
