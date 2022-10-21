class PropertiesPresenter < BasePresenter
  def klass
    PropertyFilter
  end

  def properties
    @properties ||= @filter.call.sorting_order(order_params).paginate(page: page, per_page: page_size).decorate
  end
end
  