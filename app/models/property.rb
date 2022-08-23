class Property < ApplicationRecord
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
end
