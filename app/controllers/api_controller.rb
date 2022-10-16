class ApiController < ActionController::API
  include ApiResponse
  include ApiExceptionHandler
  include RackSessionFix
end
