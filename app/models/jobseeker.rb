class Jobseeker < User
  include Mongoid::Document

  # after_create :remove_orphan_identity

  # Relationships
  has_many :identities, :dependent => :destroy
  # has_one :document, :dependent => :destroy
  # has_one :info, :dependent => :destroy
  # has_one :history, :dependent => :destroy
  # has_one :preferences, :dependent => :destroy
  # has_one :summary, :dependent => :destroy
  # has_many :skill, :dependent => :destroy
  # has_many :portfolio, :dependent => :destroy
  # has_many :listing, :dependent => :destroy

  # field :careerpath, type: String

  # Signing in with Third-Party Websites
  # field :provider, type: String 
  # field :uid, type: String 

  def self.find_for_oauth(auth, signed_in_resource=nil)
    # Get the identity and user if they exist
    identity = Identity.find_for_oauth(auth)
    user = signed_in_resource ? signed_in_resource : identity.jobseeker

    # Create the user if needed
    if user.nil?
      name = auth.extra.raw_info.name ? auth.extra.raw_info.name : "#{auth.extra.raw_info.firstName} #{auth.extra.raw_info.lastName}"
      email = auth.info.email
      user = Jobseeker.where(:email => email).first if email

      # Create the user if it's a new registration
      if user.nil?
        user = Jobseeker.new(
          name: name,
          email: email,
          password: Devise.friendly_token[0,20],
          type: 'jobseeker'
        )
        user.skip_confirmation! #if user.respond_to?(:skip_confirmation)
        user.save! validate: false
      end
    end
    # Associate the identity with the user
    identity.jobseeker = user
    identity.save! validate: false
    user
  end

  # Prevents duplication
  def remove_orphan_identity
    puts Identity.all
    # self.identities.first_or_create!(:uid => self.uid, :provider => self.provider, :user_id => self.id)
    # Identity.where(:user_id => nil).destroy_all
  end

  def first_name
    name_parts = name.split - ["#{name.split.last}"]
    name_parts.map(&:capitalize).join(" ")
  end

  def last_name
    name.split.last.capitalize
  end
end
