class Employer < User
  include Mongoid::Document

  field :contact_name, type: String

  def first_name
    name_parts = contact_name.split - ["#{contact_name.split.last}"]
    name_parts.map(&:capitalize).join(" ")
  end

  def last_name
    contact_name.split.last.capitalize
  end

  validates_uniqueness_of :name
  validates_presence_of :contact_name
  validates_presence_of :phone
end
