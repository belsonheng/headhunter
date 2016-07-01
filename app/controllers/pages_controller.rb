class PagesController < ApplicationController
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
  end
  def EHome
  end 
  def JHome
  end
end
