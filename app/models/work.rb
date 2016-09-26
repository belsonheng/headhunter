class Work
  include Mongoid::Document
  
  belongs_to :jobseeker

  field :company_name, type: String
  field :position, type: String
  field :start_date, type: Date
  field :end_date, type: Date
  field :description, type: String

  def current?
  	end_date.blank?
  end
end
