class RealEstate < ApplicationRecord

  #--------------------------------------------- RELATION
  has_one :real_estate_user_responsible, class_name: 'RealEstateUser', foreign_key: 'real_estate_responsible_id', dependent: :delete
  has_many :properties, dependent: :delete_all
  has_many :real_estate_users, dependent: :delete_all
  has_one_attached :real_estate_image, dependent: :delete_all

  #--------------------------------------------- MISC
  accepts_nested_attributes_for :real_estate_user_responsible

  #--------------------------------------------- ENUMS
  enum status: [:active, :inactive]

  #--------------------------------------------- VALIDATION
  validates :name, presence: true
  validates :description, presence: true
  validates :status, presence: true
  validates :address, presence: true

end
