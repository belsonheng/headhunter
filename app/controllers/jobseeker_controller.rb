class JobseekerController < ApplicationController
  before_filter :authenticate_user!
  def home
  	render 'pages/jobseeker/home'
  end
  def profile
  	@name = current_user.name
    @location = current_user.location
    render 'pages/jobseeker/profile/index'
  end
  def personal_info
    @user = current_user
  	render 'pages/jobseeker/profile/personal_info'
  end
  def pitch
    @user = current_user
  	render 'pages/jobseeker/profile/desired_headline'
  end
  def summary
    @user = current_user
  	render 'pages/jobseeker/profile/summary'
  end
  def role_skill
  	render 'pages/jobseeker/profile/role_skill'
  end
  def job_info
  	render 'pages/jobseeker/profile/job_info'
  end
  def history
	render 'pages/jobseeker/profile/history'
  end
  def online_presence
  	render 'pages/jobseeker/profile/online_presence'
  end
  def recommendation 
  	render 'pages/jobseeker/profile/recommendation'
  end
  def blocked_companies
  	render 'pages/jobseeker/profile/blocked_companies'
  end
  def integrations
    render 'pages/jobseeker/integrations'
  end
end
