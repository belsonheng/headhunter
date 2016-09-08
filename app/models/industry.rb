class Industry
include Mongoid::Document

has_many :roles, :dependent => :destroy
##Area of Expertise
field :area, type: String

end