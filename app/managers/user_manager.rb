class UserManager < BaseManager
  def klass
    User
  end

  def create
    @object = User.new(object_params)
    @object.send_password_reset_user_initial = true
    if @object.check_permitted_roles(@current_user, object_params[:user_role])
      if @object.save
        @object.send_reset_password_instructions
        @object 
      else
        return false
      end
    else
      return false
    end
  end

  def update
    return false unless @object.check_permitted_roles(@current_user, object_params[:user_role])
    @object.update(object_params)
  end

  def update_password
    @object.update_password(object_params)
  end
  
  def destroy
    return false unless @object.is_not_current_user?(@current_user)
    @object.destroy
  end

  private

  def permitted_params
    %i[
      first_name
      last_name
      email
      current_password
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