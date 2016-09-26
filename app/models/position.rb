class Position
  include Mongoid::Document

  belongs_to :industry
  
  field :name, type: String

  # Area of Expertise
  #field :area, type: String
end