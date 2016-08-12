class Role
include Mongoid::Document

belongs_to :industry
field :inudstry_id, type: String
field :role, type: String


end 