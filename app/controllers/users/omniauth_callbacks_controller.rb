class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def google_oauth2
    @user = User.from_google(request.env["omniauth.auth"])

    if @user.persisted?
      sign_in_and_redirect @user, event: :authentication
      set_flash_message(:notice, :success, kind: "Google") if is_navigational_format?
    else
      redirect_to new_user_session_path,
                  alert: "Google login failed."
    end
  end

  def failure
    redirect_to new_user_session_path,
                alert: "Google authentication failed."
  end
end