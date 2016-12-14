class OmniauthCallbacksController < Devise::OmniauthCallbacksController
  before_action :load_auth, only: [:facebook, :twitter]

  def facebook
    # render json: request.env['omniauth.auth']
    if @user.persisted?
      sign_in_and_redirect @user, event: :authentication
      set_flash_message(:notice, :success, kind: 'facebook') if is_navigational_format?
    else
      redirect_to new_user_registration_url
    end
  end

  def twitter
    if @user.persisted?
      sign_in_and_redirect @user, event: :authentication
      set_flash_message(:notice, :success, kind: 'twitter') if is_navigational_format?
    else
      redirect_to new_user_registration_url
    end
  end

  private

  def load_auth
    @user = User.find_for_oauth(request.env['omniauth.auth'])
  end
end
