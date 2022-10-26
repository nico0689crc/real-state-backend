module Overrides
  class PasswordsController < DeviseTokenAuth::PasswordsController
    
    def edit
      puts "asdasdasd"
    end
  end
end
