class Info
include Mongoid::Document
include Mongoid::Paperclip


belongs_to :user

has_mongoid_attached_file :avatar, :styles => { :medium => "250x300>" }, :default_url => "/app/assets/images/default.png"
 validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/

field :user_id, type: String
field :contact, type: String

end