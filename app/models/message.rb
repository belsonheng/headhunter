class Message
  include Mongoid::Document

  field :subject, type: String
  field :body, type: String
  field :sender, type: String # Email address
  field :recipient, type: String # Email address
end
