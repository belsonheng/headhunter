# class Experience 
#   include Mongoid::Document

#   # belongs_to :jobseeker

#   has_many :work
#   has_many :education

# accepts_nested_attributes_for :work, :reject_if => :all_blank, :allow_destroy => true
# accepts_nested_attributes_for :education, :reject_if => :all_blank, :allow_destroy => true

# field :place, type: String
# field :title, type: String
# field :type, type: String

# end