class PropertySerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers
  
  attributes :id, :title, :description, :p_type, :p_status, :operating_since, :price, :address, :coordinates, :sq_mts, :bathroom_amount, :beedroom_amount, :created_at, :facilities, :features, :media

  def media
    media = []

    if object.medias.attached?
      media = object.medias.map do |media|
        { id: media.id, content_type: media.blob.content_type, media_path: media.url }
      end
    end

    media
  end

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
