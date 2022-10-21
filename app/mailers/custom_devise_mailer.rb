class CustomDeviseMailer < Devise::Mailer
  default from: "Real Estate"
  layout 'mailer'
  default template_path: 'devise/mailer'

  def reset_password_instructions(record, token, opts = {})
    opts['subject'] = record.decorate.reset_password_subject
    Devise::Mailer.reset_password_instructions(record, token, opts).deliver
    record.update(send_password_reset_user_initial: false) if record.send_password_reset_user_initial
  end
end
