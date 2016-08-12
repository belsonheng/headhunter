class Summary

include Mongoid::Document
belongs_to :user

#Fields:
field :user_id, type: String
field :summary, type: String

end