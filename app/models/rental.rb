class Rental < ApplicationRecord
  belongs_to :user
  belongs_to :book

  belongs_to :librarian,
             class_name:  'User',
             foreign_key: 'librarian_id',
             optional:    true

  validates :user_id, uniqueness: { scope: :book_id, message: "Вы уже арендовали эту книгу" }
end
