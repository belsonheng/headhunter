class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :load_tweets
  before_action :configure_permitted_parameters, if: :devise_controller?

  private
  def load_tweets
    client = Twitter::REST::Client.new do |config|
      config.consumer_key        = ENV["TWITTER_CONSUMER_KEY"]
      config.consumer_secret     = ENV["TWITTER_CONSUMER_SEC"]
      config.access_token        = ENV["TWITTER_ACCESS_TOKEN"]
      config.access_token_secret = ENV["TWITTER_ACCESS_TOKEN_SEC"]
  end
    @tweets = client.user_timeline("headhunter_nyp")
  end

  protected
  def authenticate_user!
    if user_signed_in?
      super
    else
      redirect_to new_user_session_path, :notice => 'Please Sign In'
      ## if you want render 404 page
      ## render :file => File.join(Rails.root, 'public/404'), :formats => [:html], :status => 404, :layout => false
    end
  end

  protected
  def configure_permitted_parameters
    #devise_parameter_sanitizer.for(:sign_up) { |u| u.permit( :name,:contact,:location,:type,:email, :password, :password_confirmation, :company) }
    #devise_parameter_sanitizer.for(:sign_in) { |u| u.permit(:login, :username, :email, :password, :remember_me) }
    #devise_parameter_sanitizer.for(:account_update) { |u| u.permit( :email, :password, :password_confirmation, :current_password, :location) }

    devise_parameter_sanitizer.permit(:sign_up, keys: [:name,:contact,:location,:type,:email, :password, :password_confirmation, :company])
     devise_parameter_sanitizer.permit(:sign_in, keys: [:login, :username, :email, :password, :remember_me])
     devise_parameter_sanitizer.permit(:account_update, keys: [:email, :password, :password_confirmation, :current_password, :location])
  end

  def after_sign_in_path_for(resource_or_scope)
    if @user.type == "JobSeeker"
      # Path for JobSeeker
      jobseeker_home_path
    else
      # Path for Employers
      employer_home_path
    end
  end
end
