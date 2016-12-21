class Api::V1::ProfilesController < Api::V1::BaseController
  def me
    respond_with current_resourse_owner
  end

  def index
    @users = User.where.not(id: current_resourse_owner.id)
    respond_with @users
  end
end
