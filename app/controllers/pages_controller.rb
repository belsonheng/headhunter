class PagesController < ApplicationController
  before_action :authenticate_user!, :except => [:index, :employers, :how_it_works, :sitemap, :privacy, :contact]
  def index
  end
  def employers
  end
  def how_it_works
  end
  def sitemap
  	# return sitemap for download
    send_file(
      "#{Rails.root}/public/sitemap.xml.gz",
      filename: "sitemap.xml.gz",
      type: "application/xml"
    )
  end
  def privacy
    @version = "1.0"
    @last_revised_date = "June 14, 2016"
    @host = "headhunter.sit.nyp.edu.sg"
  end
  def contact
    @address = "180 Ang Mo Kio Ave 8, Singapore 569830"
    @email = "headhunter.nyp@gmail.com"
    @tel = "+65 6550 1637"
  end
  def settings
  end
  def integrations
  end
  # Onboarding actions
  def job_info
    render 'pages/onboarding/job_info'
  end
  def online_presence
    render 'pages/onboarding/online_presence'
  end
  def history
    render 'pages/onboarding/history'
  end
  def summary
    render 'pages/onboarding/summary'
  end
  def portfolio
    render 'pages/onboarding/portfolio'
  end
  def role_skill
    render 'pages/onboarding/role_skill'
  end
  def info
    render 'pages/onboarding/info'
  end
end
