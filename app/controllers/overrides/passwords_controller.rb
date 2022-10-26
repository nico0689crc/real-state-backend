module Overrides
  class PasswordsController < DeviseTokenAuth::PasswordsController
    
    def edit
      @resource = resource_class.with_reset_password_token(resource_params[:reset_password_token])

      render json: {
        token: resource_params[:reset_password_token],
        resource: @resource
      }
    end
  end
end
