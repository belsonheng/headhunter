class Offer

include Mongoid::Document
belongs_to :user
belongs_to :listing
validates :amount, :numericality => true

field :seller_id, type: String
field :amount, type: Integer
field :comment, type: String
field :listing_id, type: String

end 	