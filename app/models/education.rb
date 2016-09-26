class Education
  include Mongoid::Document

  belongs_to :jobseeker

  field :school, type: String
  field :course, type: String
  field :start_date, type: Date
  field :end_date, type: Date
  field :description, type: String
end