class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  enum :role, { reader: "reader", librarian: "librarian", administrator: "administrator" }, validate: true

  has_many :rentals
  has_many :books, through: :rentals
end
