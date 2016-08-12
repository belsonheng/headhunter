class Education

include Mongoid::Document
belongs_to :experience

field :university, type: String
field :course, type: String
field :year, type: String

end
