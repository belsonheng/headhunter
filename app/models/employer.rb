class Employer < User
  include Mongoid::Document

  field :contact_name, type: String
end
