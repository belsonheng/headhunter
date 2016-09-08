class Work

include Mongoid::Document
belongs_to :experience


field :company, type: String
field :title, type: String

field :start_Month, type: String
field :start_Year, type: String

field :end_Month, type: String
field :end_Year, type: String

field :description, type: String
field :current, type: String

end
