class Preference
  include Mongoid::Document

  belongs_to :jobseeker

  field :job_type, type: String # Contract, Temporary, Permanent 
  field :industry, type: String
  field :location, type: String
  field :expected_salary, type: Money


# field :user_id, type: String
# ##Type of Employment
# field :type, type: String
# ##Why are you interested in new Job Opportunites
# field :why, type: String
# ##Where are you in your job search?
# field :where , type: String
# ##Base Anual Salary
# field :salary , type: Integer
end
