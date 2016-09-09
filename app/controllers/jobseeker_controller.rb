class JobseekerController < ApplicationController
	before_filter :authenticate_user!
  def home
  	render 'pages/jobseeker/home'
  end
end
