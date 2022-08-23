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
    puts request.query_parameters().to_query
    
    
    links = {}
    links[:first] = get_query_page(1) if current_page > 1
    links[:previous] = get_query_page(current_page - 1) if current_page > 2
    links[:current] = get_query_page(current_page)
    links[:next] = get_query_page(current_page + 1) if current_page < presenter.presenter_pages - 2
    links[:last] = get_query_page(presenter.presenter_pages) if current_page < presenter.presenter_pages - 1

    @meta_data_json ||= {
      total: presenter.presenter_count,
      pages: presenter.presenter_pages,
      links: links
    }
  end

  def get_query_page(page) 
    path_url = "#{request.base_url}#{request.path}"
    params = request.query_parameters()
    params[:page][:number] = page

    "#{path_url}?#{CGI.unescape(params.to_query)}"
  end

  def current_page
    @current_page ||= request.query_parameters()[:page][:number].to_i
  end
end