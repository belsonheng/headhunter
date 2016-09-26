class Recommendation
  include Mongoid::Document

  belongs_to :jobseeker

  field :author_name, type: String
  field :author_email, type: String
  field :body, type: String
end