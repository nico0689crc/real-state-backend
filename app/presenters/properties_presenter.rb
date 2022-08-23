class PropertiesPresenter
    include Rails.application.routes.url_helpers
    attr_reader :filter
  
    PER_PAGE = 10
  
    def initialize(params)
      @params = params
      @filter = PropertyFilter.new(filter_params)
    end
  
    def properties
      @properties ||= @filter.call(@current_entity)
                            .sorting_order(order_params)
                            .paginate(page: page, per_page: pageSize)
                            .decorate
    end

    def presenter_count 
      @properties_count ||= @filter.call(@current_entity).count
    end

    def presenter_pages 
      @properties_pages ||= (presenter_count / pageSize.to_f).ceil
    end
  
    private
  
    def filter_params
      @params.fetch(:filter, {}).permit!
    end
  
    def page
      @params[:page].present? && @params[:page][:number].present? ? @params[:page][:number] : 1
    end

    def pageSize
      @params[:page].present? && @params[:page][:size].present? ? @params[:page][:size] : PER_PAGE
    end
  
    def order_params
      @params.fetch(:order, ['id', 'asc'])
    end
end
  