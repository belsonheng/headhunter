class Employer < User
  include Mongoid::Document

  field :company,              type: String
end
