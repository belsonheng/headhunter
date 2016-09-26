class Skill
  include Mongoid::Document

  belongs_to :jobseeker

  field :name, type: String
  
# #Area of Interest
# field :area, type: String
# # Interested Roles
# field :role, type: String
# #Years of Experince
# field :years, type: Integer
# #Skill
# field :skill, type: String 
end