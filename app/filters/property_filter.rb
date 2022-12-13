class PropertyFilter
  include ActiveModel::Model

  attr_accessor :query

  def call(current_user)
    if current_user.super_administrator? || current_user.administrator?
      properties = Property.all
    elsif current_user.real_estate_administrator?
      properties = Property.where(real_estate: current_user.real_estate)
    elsif current_user.agent?
      properties = Property.where(real_estate: current_user.real_estate, user: current_user)
    else
      raise ActiveRecord::RecordNotFound
      return false
    end
    
    properties = search(properties)
    properties
  end

  private

  def search(properties)
    properties = properties.where('properties.title LIKE :q', q: "%#{@query}%") if @query.present?
    properties
  end
end
