class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  skip_before_filter :verify_authenticity_token

  def provider
    auth = request.env['omniauth.auth']

    @user = Jobseeker.find_for_oauth(auth, current_user)

    if @user.persisted?
      puts auth.provider
      set_flash_message! :notice, :success, kind: auth.provider.capitalize if is_navigational_format?
      redirect_to request.env['omniauth.origin'] if signed_in?
      sign_in_and_redirect @user, event: :authentication unless signed_in?
    else
      session["devise.#{provider}_data"] = env['omniauth.auth']
      redirect_to jobseeker_signup_path
    end


    # # Find an identity here
    # @identity = Identity.all.find_by(:uid => auth.uid, :provider => auth.provider)

    # if @identity.nil?
    # # If no identity was found, create a brand new one here
    #   @identity = Identity.create(:uid => auth.uid, :provider => auth.provider)
    # end
    # if signed_in?
    #   if @identity.user == current_user
    #     # User is signed in so they are trying to link an identity with their
    #     # account. But we found the identity and the user associated with it 
    #     # is the current user. So the identity is already associated with 
    #     # this user. So let's display an error message.
    #     redirect_to jobseeker_home_path, notice: "Account has already been linked!"
    #   else
    #     # The identity is not associated with the current_user so lets 
    #     # associate the identity
    #     @identity.user = current_user
    #     @identity.save()
    #     redirect_to jobseeker_home_path, notice: "Account was sucessfully linked!"
    #   end
    # else
    #   if @identity.user.present?
    #     # The identity we found had a user associated with it so let's 
    #     # just log them in here
    #     user = @identity.user
    #     flash.notice = "Signed in!"
    #     user.skip_confirmation! if user.respond_to?(:skip_confirmation)
    #     sign_in_and_redirect user
    #   else
    #     # Logic for the case when we actually need to create a new user
    #       user = Jobseeker.from_omniauth(auth)
    #       if user.persisted?
    #         flash.notice = "Signed in!"
    #         sign_in_and_redirect user
    #       else
    #         session["devise.user_attributes"] = user.attributes
    #         redirect_to jobseeker_signup_path #new_user_registration_url
    #       end
    #   end
    # end
  end

  def destroy
    success = Identity.remove_oauth(params[:provider])
    flash[:error] = "Sorry, we could not disconnect your #{params[:provider].capitalize} account." unless success
    redirect_to jobseeker_integrations_url
  end

  alias_method :facebook, :provider
  alias_method :linkedin, :provider
  alias_method :google, :provider 
end