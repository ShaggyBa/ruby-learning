class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern


  include SessionsHelper
  before_action :authenticate_user!
  def check_redirect
    Rails.logger.debug "### Devise redirect check: Current user = #{current_user.inspect}"
  end

  before_action :set_locale
  before_action :ensure_locale_in_path

  private
  def set_locale
    I18n.locale = (params[:locale]&.to_sym if I18n.available_locales.include?(params[:locale]&.to_sym)) \
                  || I18n.default_locale
  end
  # Если не залогинен — редиректит на форму входа

  def default_url_options
    { locale: I18n.locale }
  end

  # Если в URL нет params[:locale], редиректим
  def ensure_locale_in_path
    return if params[:locale].present?

    redirect_to url_for(params.permit!.to_h.merge(locale: I18n.locale)), status: :moved_permanently
  end

  def redirect_to_locale
    return if params[:locale]

    default_locale = I18n.default_locale
    redirect_to url_for(locale: default_locale)
  end

  def authenticate_user!
    unless signed_in?
      flash[:alert] = "Please sign in to access that page."
      redirect_to signin_path
    end
  end
end
