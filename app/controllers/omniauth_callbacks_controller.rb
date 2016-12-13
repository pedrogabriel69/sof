class OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def facebook
    # render json: request.env['omniauth.auth']
    @user = User.find_for_oauth(request.env['omniauth.auth'])
    if @user.persisted?
      sign_in_and_redirect @user, event: :authentication
      set_flash_message(:notice, :success, kind: 'facebook') if is_navigational_format?
    else
      redirect_to new_user_registration_url
    end
  end

  def twitter
    @user = User.find_for_oauth(request.env['omniauth.auth'])
    if @user.persisted?
      sign_in @user, event: :authentication
      redirect_to edit_user_registration_path, notice: 'Successfully authenticated from twitter account. We configure random email, you need change it.'
    else
      redirect_to new_user_registration_url
    end
  end
end
