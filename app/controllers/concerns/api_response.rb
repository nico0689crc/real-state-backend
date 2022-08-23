module ApiResponse
  def json_response(data: nil, message: nil, status: :ok)
    response = {}
    response[:status] = [:ok, :created, :no_content].include?(status)? :ok : :error
    response[:message] = message if message.present?
    response[:data] = data unless data.nil?
    render json: response, status: status
  end
end