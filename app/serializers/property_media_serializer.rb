class PropertyMediaSerializer < ActiveModel::Serializer
  attributes :id, :media_path, :media_type, :status
end
