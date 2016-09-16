class User
  include Mongoid::Document
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable

  devise :database_authenticatable, :registerable, :omniauthable, :lockable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauth_providers => [:facebook, :linkedin, :google]

  # Link to other Models
  has_many :identities, :dependent => :destroy


  after_create :first_identity

  # Common attributes
  field :email, type: String
  field :encrypted_password, type: String
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


  # Prevents duplication
  def first_identity
    self.identities.first_or_create!(:uid => self.uid, :provider => self.provider, :user_id => self.id)
    Identity.where(:user_id => nil).destroy_all
  end

  def admin?
    type.casecmp('admin')
  end

  def jobseeker?
    type.casecmp('jobseeker')
  end

  def employer?
    type.casecmp('employer')
  end

  validates_uniqueness_of :email
  validates_presence_of :email
  validates_presence_of :name
  validates_presence_of :password
  validates_presence_of :location
end 
