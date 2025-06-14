class User < ApplicationRecord
  has_many :rentals
  has_many :books, through: :rentals

  def admin?
    role == 'admin'
  end

  def librarian?
    role == 'librarian'
  end

  def reader?
    role == 'reader'
  end

  def self.new_remember_token
    SecureRandom.urlsafe_base64
  end

  # Класс-метод для шифрования токена
  def self.encrypt(token)
    Digest::SHA1.hexdigest(token.to_s)
  end

  private
  # Вызывается before_create
    def create_remember_token
      self.remember_token = User.encrypt(User.new_remember_token)
    end

  has_secure_password   # автоматически использует password_digest

  before_save { self.email = email.downcase }
  before_create :create_remember_token

  ROLES = %w[reader librarian admin].freeze
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i

  validates :email, presence: true,
            uniqueness: { case_sensitive: false },
            format: { with: VALID_EMAIL_REGEX }
  validates :password, presence: true, confirmation: true, length: { minimum: 6 }, if: :password_required?

  private

  def password_required?
    new_record? || !password.nil? || !password_confirmation.nil?
  end
  validates :role, inclusion: { in: ROLES }

  # опционально: валидация по формату ключа, если хотите
  # validates :registration_key, inclusion: { in: SOME_KEY_LIST }, allow_blank: true
end

