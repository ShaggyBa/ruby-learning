class MainController < ApplicationController
  def index
    # @items = Item.all.page(params[:page])
    render "main/index"
  end


  def help
  end

  def contacts
  end

  def about
  end
end
