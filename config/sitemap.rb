# Set the host name for URL creation
SitemapGenerator::Sitemap.default_host = "http://headhuntersg.herokuapp.com/"

SitemapGenerator::Sitemap.create do
  add how_it_works_path, :changefreq => 'weekly' 
  add employers_path, :changefreq => 'weekly'

  # Need to Put in Login Features?
  add destroy_user_session_path, :changefreq => 'weekly'
  add new_user_session_path, :changefreq => 'weekly'
  add edit_user_registration_path, :changefreq => 'weekly'
  add new_user_registration_path, :changefreq => 'weekly'

  # Jobseeker Path
  add jobseeker_home_path, :changefreq => 'weekly'

  # Employer Path
  add employer_home_path, :changefreq => 'weekly'

  # Put links creation logic here.
  #
  # The root path '/' and sitemap index file are added automatically for you.
  # Links are added to the Sitemap in the order they are specified.
  #
  # Usage: add(path, options={})
  #        (default options are used if you don't specify)
  #
  # Defaults: :priority => 0.5, :changefreq => 'weekly',
  #           :lastmod => Time.now, :host => default_host
  #
  # Examples:
  #
  # Add '/articles'
  #
  #   add articles_path, :priority => 0.7, :changefreq => 'daily'
  #
  # Add all articles:
  #
  #   Article.find_each do |article|
  #     add article_path(article), :lastmod => article.updated_at
  #   end
end
