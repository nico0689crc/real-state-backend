module Overrides
  class SessionsController < DeviseTokenAuth::SessionsController
    
    protected
    
    def render_create_success

      resource_data = resource_data(resource_json: @resource.token_validation_response)

      resource_data[:image] = Faker::Avatar.image if resource_data[:image].nil?
      
      render json: {
        data: resource_data.except(
          "allow_password_change", 
          "provider", 
          "send_password_reset_user_initial", 
          "uid"
        )
      }
    end
  end
end