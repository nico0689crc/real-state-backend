class PropertySerializer < ActiveModel::Serializer
  attributes :id, :title, :description, :p_type, :p_status, :operating_since, :price, :address, :coordinates, :sq_mts, :bathroom_amount, :beedroom_amount, :created_at, :facilities, :features

  has_many :property_medias, serializer: PropertyMediaSerializer, key: :media

  def facilities
    object.facilities.select(:id, :name, :icon_name, :important)
  end

  def features
    object.features.select(:id, :name, :icon_name, :important, :p_attribute_value)
  end

  def created_at
    object.created_at.strftime("%B %d, %Y")
  end
end
