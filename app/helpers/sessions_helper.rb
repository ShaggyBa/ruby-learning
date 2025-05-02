# app/helpers/sessions_helper.rb
module SessionsHelper
  # Выполняет вход: создаёт токен, сохраняет в cookies и в БД, устанавливает current_user
  def sign_in(user)
    remember_token = User.new_remember_token
    cookies.permanent[:remember_token] = remember_token
    user.update_attribute(:remember_token, User.encrypt(remember_token))
    self.current_user = user
  end

  # Сеттер для current_user
  def current_user=(user)
    @current_user = user
  end

  # Геттер для current_user, ищет пользователя по remember_token из cookies
  def current_user
    token = User.encrypt(cookies[:remember_token])
    @current_user ||= User.find_by(remember_token: token)
  end

  # Проверка, залогинен ли пользователь
  def signed_in?
    current_user.present?
  end

  # Выход из системы: сбрасывает токен и удаляет cookie
  def sign_out
    current_user&.update_attribute(:remember_token, User.encrypt(User.new_remember_token))
    cookies.delete(:remember_token)
    self.current_user = nil
  end
end
