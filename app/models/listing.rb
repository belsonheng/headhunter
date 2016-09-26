# class Listing

# include Mongoid::Document
# belongs_to :user 
# has_many :offer, :dependent => :destroy

# #Fields:
# field :user_id, type: String
# field :status, type: String
# field :end_time, type: DateTime
# ##Area of Expertise
# field :area, type: String
# #Requested Amount 
# field :amount, type: Integer

# def closed?
#     self.end_time < Time.now
#   end

#   def self.get_active_auctions
#     where("end_time > ?", Time.now)
#   end
# end