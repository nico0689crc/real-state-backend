module Overrides
  class PasswordsController < DeviseTokenAuth::PasswordsController
    
    def edit
      @resource = resource_class.with_reset_password_token(resource_params[:reset_password_token])

      render json: {
        resource: @resource,
        token: resource_params[:reset_password_token],
        first_condition: @resource && @resource.reset_password_period_valid?
      }
    end
  end
end
