class JobseekerController < ApplicationController
  before_filter :authenticate_user!
  def home
  	render 'pages/jobseeker/home'
  end
  def profile
  	@name = current_user.name
    render 'pages/jobseeker/profile'
  end
end
