class Preferences

include Mongoid::Document
belongs_to :user
field :user_id, type: String
##Type of Employment
field :type, type: String
##Why are you interested in new Job Opportunites
field :why, type: String
##Where are you in your job search?
field :where , type: String
##Base Anual Salary
field :salary , type: Integer

end
