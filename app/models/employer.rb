class Employer < User
  include Mongoid::Document

  field :contact_name, type: String

  def first_name
    contact_name.split(' ')[0].capitalize
  end

  def last_name
    contact_name.split(' ')[1].capitalize
  end

  validates_uniqueness_of :name
  validates_presence_of :contact_name
  validates_presence_of :phone
end
