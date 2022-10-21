class UserFilter
  include ActiveModel::Model

  attr_accessor :query

  def call
    users = User.all
    users = search(users)
    users
  end

  private

  def search(users)
    users = users.where('users.email LIKE :q', q: "%#{@query}%") if @query.present?
    users
  end
end
