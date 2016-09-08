class Experience 

include Mongoid::Document
belongs_to :user

has_many :work
has_many :education

accepts_nested_attributes_for :work, :reject_if => :all_blank, :allow_destroy => true
accepts_nested_attributes_for :education, :reject_if => :all_blank, :allow_destroy => true

field :user_id, type: String

end