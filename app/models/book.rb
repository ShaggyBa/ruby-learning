class Book < ApplicationRecord

  has_many :rentals
  has_many :users, through: :rentals

  # Возвращает книги, отсортированные по количеству аренд (спадание)
  scope :most_rented, ->(limit = 5) {
    joins(:rentals)
      .group("books.id")
      .order("COUNT(rentals.id) DESC")
      .limit(limit)
  }
end
