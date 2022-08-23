class ApiController < ActionController::API
  include ApiResponse
  include RackSessionFix
end
