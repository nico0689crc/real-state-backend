class ApplicationController < ActionController::API
  include RackSessionFix
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    added_attrs = [:email, :password, :password_confirmation, :first_name, :last_name, :phone_number, :address, :date_of_birth, :gender, :user_role]
    devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
    devise_parameter_sanitizer.permit :sign_in, keys: [:email, :password]
    devise_parameter_sanitizer.permit :account_update, keys: added_attrs
  end
end
