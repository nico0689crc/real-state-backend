class RealEstateFilter
  include ActiveModel::Model

  attr_accessor :query

  def call(current_user)
    if current_user.super_administrator? || current_user.administrator?
      real_estates = RealEstate.all
    else
      raise ActiveRecord::RecordNotFound
      return false
    end
    
    real_estates = search(real_estates)
    real_estates
  end

  private

  def search(real_estates)
    real_estates = real_estates.where('real_estates.name LIKE :q', q: "%#{@query}%") if @query.present?
    real_estates
  end
end
