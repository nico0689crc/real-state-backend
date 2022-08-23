class PropertySerializer < ActiveModel::Serializer
  attributes :id, :title, :description, :p_type, :p_status, :operating_since, :price, :address, :coordinates, :facilities, :features, :sq_mts

  def facilities
    JSON.parse(object.facilities)
  end

  def features
    JSON.parse(object.features)
  end

end
