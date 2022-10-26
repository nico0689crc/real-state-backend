module Overrides
  class PasswordsController < DeviseTokenAuth::PasswordsController
    
    def edit
      @resource = resource_class.with_reset_password_token(resource_params[:reset_password_token])
      token = @resource.create_token unless require_client_password_reset_token?
      redirect_to @resource.build_auth_url(@redirect_url, build_redirect_headers(token.token, token.client, { reset_password: true })), allow_other_host: true
#       render json: {
#         resource: @resource,
#         token: resource_params[:reset_password_token],
#         first_condition: @resource && @resource.reset_password_period_valid?,
#         require_client_password_reset_token: require_client_password_reset_token?,
#         create_token: @resource.create_token,
#         skip_confirmation: confirmable_enabled? && !@resource.confirmed_at,
#         allow_password_change: recoverable_enabled?,
#         save: @resource.save!,
#         block_given: block_given?,
#         require_client_password_reset_token: require_client_password_reset_token?,
#         cookie_enabled: DeviseTokenAuth.cookie_enabled,
#         token_token: token.token,
#         token_client: token.client,
#         redirect_headers: build_redirect_headers(token.token, token.client, { reset_password: true }),
#         redirect_url: @redirect_url,
#         build_auth_url:  @resource.build_auth_url(@redirect_url, build_redirect_headers(token.token, token.client, { reset_password: true }))
#       }
    end
  end
end
