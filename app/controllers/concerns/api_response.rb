module ApiResponse
  def json_response(data: nil, message: nil, status: :ok, presenter: nil)
    response = {}
    response[:status] = [:ok, :created, :no_content].include?(status)? :ok : :error
    response[:message] = message if message.present?
    response[:data] = data unless data.nil?
    response[:meta] = meta_data_json(presenter) unless presenter.nil?
    render json: response, status: status
  end

  private

  def meta_data_json(presenter)
    @meta_data_json ||= {
      current_page: current_page,
      total: presenter.presenter_count,
      pages: presenter.presenter_pages
    }
  end

  def current_page
    @current_page ||= request.query_parameters()[:page][:number].to_i
  end
end