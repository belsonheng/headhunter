class Identity
  include Mongoid::Document
  
  belongs_to :jobseeker
  
  field :uid, type: String
  field :provider, type: String
  field :token, type: String
  field :secret, type: String

  def self.find_for_oauth(auth) 
  	find_or_create_by(uid: auth.uid, provider: auth.provider, token: auth.credentials.token, secret: auth.credentials.secret)
  end

  validates_uniqueness_of :uid, :scope => :provider
  validates_presence_of :uid, :provider

  # index({ uid: 1}, {drop_dups: false, background: true})
end