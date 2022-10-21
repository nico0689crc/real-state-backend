class UserSerializer < ActiveModel::Serializer
  attributes :id, :first_name, :last_name, :user_role, :email, :phone_number, :address, :date_of_birth, :gender, :avatar

  def avatar
    object.avatar_image.attached? ? object.avatar_image : Faker::Avatar.image
  end

  def date_of_birth
    object.date_of_birth.strftime("%m/%d/%Y") unless object.date_of_birth.nil?
  end
end
