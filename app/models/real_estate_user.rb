class RealEstateUser < User
  has_many :properties
  belongs_to :real_estate, optional: true
  belongs_to :real_estate_responsible, class_name: 'RealEstate'
end