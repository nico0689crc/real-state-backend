class Property < ApplicationRecord
  has_many :property_attributes

  enum p_type: [:house, :appartment, :commercial_building]
  enum p_status: [:rent, :sale, :inactive]

  validates :title, presence: true
  validates :description, presence: true
  validates :p_type, presence: true
  validates :p_status, presence: true
  validates :address, presence: true
  validates :title, presence: true
  validates :title, presence: true
  validates :title, presence: true

  def facilities
    self.property_attributes.filter_facilities
  end

  def features
    self.property_attributes.filter_features
  end
end
