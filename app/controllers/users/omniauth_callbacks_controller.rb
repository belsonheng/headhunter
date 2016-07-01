class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def facebook
    # You need to implement the method below in your model (e.g. app/models/user.rb)
    @user = User.from_omniauth(request.env["omniauth.auth"])
     #user.type ="JobSeeker"
    if @user.persisted?
      @user.skip_confirmation!
      sign_in_and_redirect @user, :event => :authentication #this will throw if @user is not activated
      set_flash_message(:notice, :success, :kind => "Facebook") if is_navigational_format?
    else
      flash[:notice] = "An error has occured, Please Register a new account or try again"
      session["devise.facebook_data"] = request.env["omniauth.auth"]
      redirect_to new_user_registration_url
    end
  end
  
  def linkedin
    @user = User.from_omniauth(request.env["omniauth.auth"])

    if @user.persisted?
      @user.skip_confirmation!
      sign_in_and_redirect @user, :event => :authentication
      set_flash_message(:notice, :success, :kind => "LinkedIn") if is_navigational_format?
    else
      flash[:notice] = "An error has occured, Please Register a new account or try again"
      session["devise.linkedin_uid"] = request.env["omniauth.auth"].except("extra")
      redirect_to new_user_session_url
    end
  end

  def google
    # You need to implement the method below in your model (e.g. app/models/user.rb)
    @user = User.from_omniauth(request.env["omniauth.auth"])

    if @user.persisted?
      @user.skip_confirmation!
      flash[:notice] = I18n.t "devise.omniauth_callbacks.success", :kind => "Google"
      sign_in_and_redirect @user, :event => :authentication
    else
      flash[:notice] = "An error has occured, Please Register a new account or try again"
      session["devise.google_data"] = request.env["omniauth.auth"]
      redirect_to new_user_registration_url
    end
  end

  def failure
    redirect_to root_path
  end
end