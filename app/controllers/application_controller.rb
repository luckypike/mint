class ApplicationController < ActionController::Base
  include Pundit

  rescue_from Pundit::NotAuthorizedError, with: :not_authenticated

  protect_from_forgery with: :exception

  before_action :set_current

  after_action :verify_authorized

  around_action :switch_locale

  private

  def set_current
    Current.user = current_user
  end

  def not_authenticated
    session[:return_to_url] = request.original_fullpath
    redirect_to new_user_session_path, alert: t(:login_first)
  end

  def set_user
    unless user_signed_in?
      user = User.new(email: "guest_#{Devise.friendly_token.first(10)}@golovina.store")
      user.save!(validate: false)
      sign_in(user)
    end
  end

  def switch_locale(&action)
    locale = extract_locale_from_subdomain || I18n.default_locale

    I18n.with_locale(locale, &action)
  end

  def extract_locale_from_subdomain
    parsed_locale = request.subdomains.first
    I18n.available_locales.map(&:to_s).include?(parsed_locale) ? parsed_locale : nil
  end
end
