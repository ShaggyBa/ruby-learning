# db/seeds.rb

# Импорт Faker
require 'faker'
# db/seeds.rb

# Очистить существующих пользователей (если нужно)
Rental.delete_all
User.delete_all
Book.delete_all

# Далее создаём новых пользователей и данные
users = User.create!([
                       { email: 'admin@example.com', password: 'password', role: 'administrator' },
                       { email: 'librarian@example.com', password: 'password', role: 'librarian' },
                       { email: 'reader@example.com', password: 'password', role: 'reader' }
                     ])

puts "Создано #{users.count} пользователей"

# Создание книг с использованием Faker
books = 10.times.map do
  Book.create!(
    book_name: Faker::Book.title,
    author: Faker::Book.author,
    image: Faker::LoremFlickr.image(size: "50x60"),
    count: rand(1..10)
  )
end

puts "Создано #{books.count} книг"

# Создание аренды книг
rentals = 5.times.map do
  Rental.create!(
    user: users.sample,
    book: books.sample,
    rent_date: Faker::Date.backward(days: 14),
    collection_period: rand(7..30)
  )
end

puts "Создано #{rentals.count} записей аренды"
