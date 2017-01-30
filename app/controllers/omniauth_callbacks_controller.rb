class OmniauthCallbacksController < Devise::OmniauthCallbacksController
  before_action :auth, only: [:facebook, :sign_in_email]
  before_action :load_logic, only: [:sign_in_email]

  def facebook
    # render json: request.env['omniauth.auth']
    @user = User.find_for_oauth(auth)
    if @user && @user.persisted?
      sign_in_and_redirect @user, event: :authentication
      set_flash_message(:notice, :success, kind: 'facebook') if is_navigational_format?
    else
      redirect_to new_user_registration_url
    end
  end

  def twitter
    render json: request.env['omniauth.auth']
  end

  def sign_in_email; end

  private

  def load_logic
    @user = User.find_for_oauth(auth)
    if @user && @user.persisted?
      sign_in_and_redirect @user, event: :authentication
      set_flash_message(:notice, :success, kind: 'twitter') if is_navigational_format?
    else
      flash[:notice] = 'Text Email for sign up.'
      render 'common/add_email', locals: { auth: request.env['omniauth.auth'] }
    end
  end

  def auth
    request.env['omniauth.auth'] || OmniAuth::AuthHash.new(params[:auth])
  end
end
