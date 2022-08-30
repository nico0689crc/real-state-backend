class PropertyAttribute < ApplicationRecord
  belongs_to :property

  enum p_attribute_type: [:feature, :facility]

  scope :filter_facilities, -> { where(p_attribute_type: :facility) }
  scope :filter_features, -> { where(p_attribute_type: :feature) }

  validates :name, presence: true
  validates :icon_name, presence: true
  validates :important, presence: true
  validates :p_attribute_type, presence: true
end
