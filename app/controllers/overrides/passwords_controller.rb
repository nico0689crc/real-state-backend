module Overrides
  class PasswordsController < DeviseTokenAuth::PasswordsController
    
    def edit
      render "asdasdasd"
    end
  end
end
