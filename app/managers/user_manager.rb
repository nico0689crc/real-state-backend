class UserManager < BaseManager
  def klass
    User
  end

  def create
    @object = User.new(object_params)
    @object.send_password_reset_user_initial = true
    @object.save
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