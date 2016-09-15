class Employer < User
  include Mongoid::Document

  field :contact_name, type: String

  validates_presence_of :contact_name
end
