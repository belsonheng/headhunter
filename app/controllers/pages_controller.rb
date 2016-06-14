class PagesController < ApplicationController
  def index
  end
  def employers
  end
  def how_it_works
  end
  def sitemap
  	# return sitemap for download
  end
  def privacy
    @version = "1.0"
    @last_revised_date = "June 14, 2016"
    @host = "headhunter.sit.nyp.edu.sg"
  end
  def contact
  end
end
