class Identity
  include Mongoid::Document
  
  belongs_to :jobseeker
  
  field :uid, type: String
  field :provider, type: String

  def self.find_for_oauth(auth) 
  	find_or_create_by(uid: auth.uid, provider: auth.provider)
  end

  def self.remove_oauth(provider)
    where(provider: provider).destroy
  end

  validates_uniqueness_of :uid, :scope => :provider
  validates_presence_of :uid, :provider
end