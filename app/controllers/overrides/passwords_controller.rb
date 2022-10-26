module Overrides
  class PasswordsController < DeviseTokenAuth::PasswordsController
    
    def edit
      render json: {
        data: "Nicolas"
      }
    end
  end
end
