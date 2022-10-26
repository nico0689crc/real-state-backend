module Overrides
  class PasswordsController < DeviseTokenAuth::PasswordsController
    
    def edit
      @resource = resource_class.with_reset_password_token(resource_params[:reset_password_token])

      render json: {
        resource: @resource,
        token: resource_params[:reset_password_token],
        first_condition: @resource && @resource.reset_password_period_valid?,
        require_client_password_reset_token: require_client_password_reset_token?,
        create_token: @resource.create_token,
        skip_confirmation: confirmable_enabled? && !@resource.confirmed_at,
        allow_password_change: recoverable_enabled?,
        save: @resource.save!,
        block_given: block_given?,
        require_client_password_reset_token: require_client_password_reset_token?,
        cookie_enabled: DeviseTokenAuth.cookie_enabled
      }
    end
  end
end
