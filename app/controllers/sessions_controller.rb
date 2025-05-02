class SessionsController < ApplicationController
  include SessionsHelper
  skip_before_action :authenticate_user!, only: %i[new create]

  def new
  end

  def create
    user = User.find_by(email: params[:email]&.downcase)
    if user&.authenticate(params[:password])
      sign_in user
      redirect_to main_index_path, notice: 'Signed in successfully'
    else
      flash.now[:alert] = 'Invalid email/password combination'
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    sign_out
    redirect_to root_path, notice: 'Signed out'
  end
end
