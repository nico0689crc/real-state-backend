class RealEstateSerializer < ActiveModel::Serializer
  
  attributes :id, :name, :description, :contact_phone, :contact_email, :address, :real_estate_image, :fake_real_estate_image, :properties

  has_many :properties, serializer: PropertySerializer, key: :properties
  has_many :real_estate_user_responsible, serializer: UserSerializer, key: :real_estate_user_responsible

  def real_estate_image
    { 
      id: real_estate_image.id, 
      content_type: real_estate_image.blob.content_type, 
      media_path: real_estate_image.url 
    } if object.real_estate_image.attached?
  end

  def fake_real_estate_image
    Faker::Avatar.image(format: "jpg")
  end
end
