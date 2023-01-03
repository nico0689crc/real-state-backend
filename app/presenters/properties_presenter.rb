class PropertiesPresenter < BasePresenter
  def klass
    PropertyFilter
  end

  def properties
    @properties ||= @filter.call(@current_user).sorting_order(order_params).paginate(page: page, per_page: page_size).decorate
  end

  def properties_public
    @properties_public ||= @filter.call_public.sorting_order(order_params).paginate(page: page, per_page: page_size).decorate
  end
end
  