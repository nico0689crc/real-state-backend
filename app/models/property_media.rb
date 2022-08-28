class PropertyMedia < ApplicationRecord
  belongs_to :property

  enum media_type: [:image, :video, :audio]
  enum status: [:active, :inactive]

  validates :media_path, presence: true
end
