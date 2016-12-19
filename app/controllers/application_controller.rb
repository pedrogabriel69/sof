require 'application_responder'

class ApplicationController < ActionController::Base
  self.responder = ApplicationResponder
  respond_to :html

  protect_from_forgery with: :exception
  skip_before_action :verify_authenticity_token

  before_action :gon_user, unless: :devise_controller?

  rescue_from CanCan::AccessDenied do |e|
    respond_to do |format|
      format.html { redirect_to root_url, alert: e.message }
      format.js { render nothing: true, status: :forbidden }
      format.json { render json: e.message, status: :unauthorized }
    end
  end

  check_authorization unless: :devise_controller?

  def gon_user
    gon.user_id = current_user.id if current_user
  end
end
