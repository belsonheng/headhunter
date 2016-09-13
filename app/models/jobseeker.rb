class Jobseeker < User
  include Mongoid::Document

  field :careerpath, type: String
end
