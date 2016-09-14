class EmployerController < ApplicationController
  before_filter :authenticate_user!
  def home
  	puts current_user.inspect
  	@contact_name = current_user.contact_name
  	render 'pages/employer/home'
  end
end
