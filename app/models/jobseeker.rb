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
end
