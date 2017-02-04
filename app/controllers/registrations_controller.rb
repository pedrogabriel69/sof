# RegistrationsController
class RegistrationsController < Devise::RegistrationsController
  prepend_before_action :check_captcha, only: [:create]

  private

  def sign_up_params
    allow = [:name, :email, :password, :password_confirmation]
    params.require(resource_name).permit(allow)
  end

  def check_captcha
    unless verify_recaptcha
      self.resource = resource_class.new sign_up_params
      respond_with_navigational(resource) { render :new }
    end
  end
end
