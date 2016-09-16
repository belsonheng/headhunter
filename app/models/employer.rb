class Employer < User
  include Mongoid::Document

  field :contact_name, type: String

  validates_uniqueness_of :name
  validates_presence_of :contact_name
  validates_presence_of :phone
end
