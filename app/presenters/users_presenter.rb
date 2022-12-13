class UsersPresenter < BasePresenter
  def klass
    UserFilter
  end

  def users
    @users ||= @filter.call(@current_user).order(user_role: :asc).paginate(page: page, per_page: page_size).decorate
  end
end