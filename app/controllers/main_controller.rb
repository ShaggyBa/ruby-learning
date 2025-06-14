class MainController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[index]
  def index
    if signed_in? && current_user.reader?
      return redirect_to library_path
    end
    end


    def help
  end

  def contacts
  end

  def about
  end
end
