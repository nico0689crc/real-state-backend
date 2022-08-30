class PropertyAttributeSerializer < ActiveModel::Serializer
  attributes :id, :name, :icon_name, :important, :p_attribute_type
end
