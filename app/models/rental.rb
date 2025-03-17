class Rental < ApplicationRecord
  belongs_to :user
  belongs_to :book

  validates :user_id, uniqueness: { scope: :book_id, message: "Вы уже арендовали эту книгу" }
end
