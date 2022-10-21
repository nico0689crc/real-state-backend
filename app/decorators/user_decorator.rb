class UserDecorator < ApplicationDecorator
  delegate_all

  def reset_password_subject
    reset_password_info[:subject]
  end

  def reset_password_template
    reset_password_info[:template]
  end

  def reset_password_info
    if send_password_reset_user_initial?
      case user_role
      when :super_administrator
        {subject: "Welcome to Real Estate #{first_name}", template: :reset_first_password_real_estate_admin}
      else :administrator
        {subject: "Welcome to Real Estate #{first_name}", template: :reset_first_password_real_estate_superadmin}
      end 
    else
      {subject: "Reset password instructions", template: :reset_password_instructions_original}
    end
  end
end
