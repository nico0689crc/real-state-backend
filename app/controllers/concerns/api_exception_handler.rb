module ApiExceptionHandler
  extend ActiveSupport::Concern

  included do
    rescue_from ActiveRecord::RecordNotFound do |e|
      json_response(message: e.message, status: :not_found)
    end

    rescue_from CanCan::AccessDenied do |e|
      json_response(message: e.message, status: :not_found)
    end

    def authenticate_user!(options = {})
      json_response(message: I18n.t('devise.failure.unauthenticated'), status: :unauthorized) unless user_signed_in?
    end
  end
end