Devise.setup do |config|
  config.mailer_sender = ENV["MAIL_SENDER"]
end
