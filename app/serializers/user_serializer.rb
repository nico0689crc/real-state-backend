class UserSerializer < ActiveModel::Serializer
  attributes :id, :first_name, :last_name, :user_role, :email, :phone_number, :address, :date_of_birth, :gender
end
