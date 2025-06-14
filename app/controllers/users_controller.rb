# app/controllers/users_controller.rb
class UsersController < ApplicationController
  include SessionsHelper


  skip_before_action :authenticate_user!, only: %i[register create]
  skip_load_and_authorize_resource only: %i[register create]

  before_action :authenticate_user!, except: %i[register create]
  load_and_authorize_resource except: %i[register create]

  # GET /users
  def index
    @users = User.accessible_by(current_ability).where.not(id: current_user.id)
  end

  # GET /users/:id
  def show
  end

  # GET /users/new
  # Админ создаёт нового пользователя
  def new
    @user = User.new
    render :new # форма для админа
  end

  # Обычный пользователь регистрируется
  def register
    @user = User.new
    render :register # форма для обычного пользователя
  end

  # POST /users
  def create
    @user = User.new(user_params)
    check_registration_key

    if @user.save
      # Если пользователь сам себя регистрирует — авторизуем
      sign_in(@user) if current_user.nil?
      redirect_to main_index_path, notice: 'Пользователь создан!'
    else
      if current_user&.admin?
        render :new, status: :unprocessable_entity
      else
        render :register, status: :unprocessable_entity
      end
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
      @user.role = 'reader'
    end
  end
end
