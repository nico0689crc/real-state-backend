class UserFilter
  include ActiveModel::Model

  attr_accessor :query

  def call(current_user)
    if current_user.super_administrator?
      users = User.all
    elsif current_user.real_estate_administrator?
      users = current_user.real_estate.real_estate_users
    else
      raise ActiveRecord::RecordNotFound
      return false
    end
    users = search(users)
    users
  end

  private

  def search(users)
    users = users.where('users.email LIKE :q', q: "%#{@query}%") if @query.present?
    users
  end
end
