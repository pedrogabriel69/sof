class Api::V1::ProfilesController < Api::V1::BaseController
  skip_authorization_check

  def me
    respond_with current_resource_owner
  end

  def index
    @users = User.where.not(id: current_resource_owner.id)
    respond_with @users
  end
end
