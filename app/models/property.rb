class Property < ApplicationRecord
  has_many :property_attributes, dependent: :delete_all
  has_many_attached :medias, dependent: :delete_all
  belongs_to :real_estate
  belongs_to :user

  enum p_type: [:house, :appartment, :commercial_building]
  enum p_status: [:rent, :sale, :inactive]

  scope :filter_inactives, -> { where.not(p_status: :inactive) }

  validates :title, presence: true
  validates :description, presence: true
  validates :p_type, presence: true
  validates :p_status, presence: true
  validates :address, presence: true
  validates :real_estate, presence: true

  def facilities
    self.property_attributes.filter_facilities
  end

  def features
    self.property_attributes.filter_features
  end
end
