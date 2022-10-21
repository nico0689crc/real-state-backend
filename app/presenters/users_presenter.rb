class UsersPresenter < BasePresenter
  def klass
    UserFilter
  end

  def users
    @users ||= @filter.call.paginate(page: page, per_page: page_size).decorate
  end
end