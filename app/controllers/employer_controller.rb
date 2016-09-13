class EmployerController < ApplicationController
  before_filter :authenticate_user!
  def home
  	render 'pages/employer/home'
  end
end
