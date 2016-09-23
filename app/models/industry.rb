class Industry
  include Mongoid::Document

  has_many :positions, :dependent => :destroy
  
  field :name, type: String

  # Area of Expertise
  #field :area, type: String
end