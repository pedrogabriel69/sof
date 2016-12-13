# RegistrationsController
class RegistrationsController < Devise::RegistrationsController
  private

  def sign_up_params
    allow = [:name, :email, :password, :password_confirmation]
    params.require(resource_name).permit(allow)
  end

  protected

  def update_resource(resource, params)
    resource.update_without_password(params)
  end
end
