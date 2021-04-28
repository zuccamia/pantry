class OmniauthCallbacksController < Devise::OmniauthCallbacksController

  def line
    @user = User.from_omniauth(request.env["omniauth.auth"])

    if @user.persisted?
      sign_in_and_redirect @user, event: :authentication
      flash.now[:notice] = "Signed in with LINE!" if is_navigational_format?
    else
      session["devise.line_data"] = request.env["omniauth.auth"]
      redirect_to new_user_registration_path
    end
  end
end
