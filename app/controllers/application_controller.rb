class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern


  def check_redirect
    Rails.logger.debug "### Devise redirect check: Current user = #{current_user.inspect}"
  end
end
