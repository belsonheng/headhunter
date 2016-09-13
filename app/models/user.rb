class User
  include Mongoid::Document
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  # Resume

  devise :database_authenticatable, :registerable, :omniauthable, :lockable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauth_providers => [:facebook, :linkedin, :google]

  # Link to other Models
  has_one :document, :dependent => :destroy
  has_one :info, :dependent => :destroy
  has_one :history, :dependent => :destroy
  has_one :preferences, :dependent => :destroy
  has_one :summary, :dependent => :destroy
  has_many :identities, :dependent => :destroy
  has_many :skill, :dependent => :destroy
  has_many :portfolio, :dependent => :destroy
  has_many :listing, :dependent => :destroy

  after_create :first_identity

  # Database authenticatable
  field :email, type: String, default: ""
  field :encrypted_password, type: String, default: ""
  field :name, type: String
  field :location, type: String
  field :phone, type: String
  
  # Recoverable
  field :reset_password_token,   type: String
  field :reset_password_sent_at, type: Time

  # Type of User (To identify them) 
  field :type, type: String

  ## Rememberable
  field :remember_created_at, type: Time

  ## Trackable
  field :sign_in_count,      type: Integer, default: 0
  field :current_sign_in_at, type: Time
  field :last_sign_in_at,    type: Time
  field :current_sign_in_ip, type: String
  field :last_sign_in_ip,    type: String

  #Loging in with Third-Party Websites (JobSeekers)
  field :provider, type: String 
  field :uid, type: String 

  # JobSeekers Attr.
 

  # Employer Attr.
  field :company, type: String
  field :contact, type: String

  # Profile Picture:
   
  # Confirmable
  field :confirmation_token, type: String
  field :confirmed_at, type: Time
  field :confirmation_sent_at, type: Time
  field :unconfirmed_email, type: String # Only if using reconfirmable

  # Lockable
  field :failed_attempts, type: Integer, default: 0 # Only if lock strategy is :failed_attempts
  field :unlock_token, type: String # Only if unlock strategy is :email or :both
  field :locked_at, type: Time


  def self.from_omniauth(auth)
    where(auth.slice(:uid, :provider)).first_or_create do |user|
      user.uid = auth.uid
      user.provider = auth.provider
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
      user.type = "JobSeeker"
    end
  end

  # Prevents duplication
  def first_identity
    self.identities.first_or_create!(:uid => self.uid, :provider => self.provider, :user_id => self.id)
    Identity.where(:user_id => nil).destroy_all
  end
end 
