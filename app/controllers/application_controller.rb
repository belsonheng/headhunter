class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :load_tweets
  before_action :configure_permitted_parameters, if: :devise_controller?

  private
  def load_tweets
  	@tweets = "my recent 3 tweets here"
  end

    protected
def configure_permitted_parameters
  devise_parameter_sanitizer.for(:sign_up) { |u| u.permit( :name,:contact,:careerpath,:type,:email, :password, :password_confirmation, :company) }
  devise_parameter_sanitizer.for(:sign_in) { |u| u.permit(:login, :username, :email, :password, :remember_me) }
  devise_parameter_sanitizer.for(:account_update) { |u| u.permit( :email, :password, :password_confirmation, :current_password) }
end
end
