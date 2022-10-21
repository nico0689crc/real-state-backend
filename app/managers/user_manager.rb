class UserManager < BaseManager
  def klass
    User
  end

  def create
    ActiveRecord::Base.transaction do
      @object = User.new(object_params)
      @object.send_password_reset_user_initial = true
      
      if @object.save
        if @object.send_reset_password_instructions
          true
        else
          raise ActiveRecord::Rollback
          false
        end 
      end
    end
  end
  
  def destroy
    if @object.is_not_current_user?(@current_user)
      @object.destroy
    else
      false
    end
  end

  private

  def permitted_params
    %i[
      first_name
      last_name
      email
      password
      password_confirmation
      phone_number
      address
      date_of_birth
      gender
      user_role
    ]
  end
end