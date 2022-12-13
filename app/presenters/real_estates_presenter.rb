class RealEstatesPresenter < BasePresenter
  def klass
    RealEstateFilter
  end

  def real_estates
    @real_estates ||= @filter.call(@current_user).sorting_order(order_params).paginate(page: page, per_page: page_size).decorate
  end
end
  