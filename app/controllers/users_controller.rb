# app/controllers/users_controller.rb
class UsersController < ApplicationController
  include SessionsHelper  # чтобы sign_in/sign_out работали
  require 'digest/sha1'
  before_action :set_user, only: %i[show edit update destroy]
  skip_before_action :authenticate_user!, only: %i[new create]

  # GET /users
  def index
    @users = User.all
  end

  # GET /users/:id
  def show
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # POST /users
  def create
    @user = User.new(user_params)
    check_registration_key

    if @user.save
      sign_in @user
      redirect_to main_index_path, notice: 'Registration successful!'
    else
      render :new, status: :unprocessable_entity
    end
  end

  # GET /users/:id/edit
  def edit
  end

  # PATCH/PUT /users/:id
  def update
    if @user.update(user_params)
      redirect_to @user, notice: 'User was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /users/:id
  def destroy
    @user.destroy!
    redirect_to users_path, notice: 'User was successfully destroyed.', status: :see_other
  end

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user)
          .permit(:email, :password, :password_confirmation, :registration_key, :avatar)
  end

  def check_registration_key
    case @user.registration_key
    when Rails.application.credentials.dig(:registration_keys, :librarian)
      @user.role = 'librarian'
    when Rails.application.credentials.dig(:registration_keys, :admin)
      @user.role = 'admin'
    else
      @user.role = 'user'
    end
  end
end
