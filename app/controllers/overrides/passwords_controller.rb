module Overrides
  class PasswordsController < DeviseTokenAuth::PasswordsController
    
    def edit
      @resource = resource_class.with_reset_password_token(resource_params[:reset_password_token])

      render json: {
        resource: @resource,
        token: resource_params[:reset_password_token],
        first_condition: @resource && @resource.reset_password_period_valid?,
        require_client_password_reset_token: require_client_password_reset_token?
      }
    end
  end
end
