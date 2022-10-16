class AdminController < ApiController
  include DeviseTokenAuth::Concerns::SetUserByToken
  before_action :authenticate_user!
  authorize_resource
end