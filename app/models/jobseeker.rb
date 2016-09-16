class Jobseeker < User
  include Mongoid::Document

  has_one :document, :dependent => :destroy
  has_one :info, :dependent => :destroy
  has_one :history, :dependent => :destroy
  has_one :preferences, :dependent => :destroy
  has_one :summary, :dependent => :destroy
  has_many :skill, :dependent => :destroy
  has_many :portfolio, :dependent => :destroy
  has_many :listing, :dependent => :destroy

  # field :careerpath, type: String

  def self.from_omniauth(auth)
    where(auth.slice(:uid, :provider)).first_or_create do |user|
      user.uid = auth.uid
      user.provider = auth.provider
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
      user.type = "jobseeker"
    end
  end
end
