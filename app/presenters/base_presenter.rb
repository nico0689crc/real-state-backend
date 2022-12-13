class BasePresenter
  include Rails.application.routes.url_helpers
  attr_reader :filter

  PER_PAGE = 10

  def initialize(params: nil, current_user: nil)
    @params = params
    @current_user = current_user
    @filter = klass.new(filter_params)
  end

  def presenter_count 
    @properties_count ||= @filter.call(@current_user).count
  end

  def presenter_pages 
    @properties_pages ||= (presenter_count / page_size.to_f).ceil
  end

  private

  def filter_params
    @params.fetch(:filter, {}).permit!
  end

  def page
    @params[:page].present? && @params[:page][:number].present? ? @params[:page][:number] : 1
  end

  def page_size
    @params[:page].present? && @params[:page][:size].present? ? @params[:page][:size] : PER_PAGE
  end

  def order_params
    @params.fetch(:order, ['id', 'asc'])
  end
end
  