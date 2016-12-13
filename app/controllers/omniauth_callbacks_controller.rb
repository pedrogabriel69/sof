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
      sign_in @user, event: :authentication
      check(request.env['omniauth.auth'], @user)
    else
      redirect_to new_user_registration_url
    end
  end

  private

  def load_auth
    @user = User.find_for_oauth(request.env['omniauth.auth'])
  end

  def check(auth, user)
    if user.email == "#{auth.info[:nickname]}@sof.sof"
      edit_email_url
    else
      root_url
    end
  end

  def root_url
    redirect_to root_path, notice: "Successfully authenticated from twitter account."
  end

  def edit_email_url
    redirect_to edit_user_registration_path, notice: 'Successfully authenticated from twitter account. We configure random email, you need change it.'
  end
end
