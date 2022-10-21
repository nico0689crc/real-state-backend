class PropertyFilter
  include ActiveModel::Model

  attr_accessor :query

  def call
    properties = Property.all
    properties = search(properties)
    properties
  end

  private

  def search(properties)
    properties = properties.where('properties.title LIKE :q', q: "%#{@query}%") if @query.present?
    properties
  end
end
