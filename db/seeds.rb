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

# Список книг с изображениями из assets
book_list = [
  { book_name: 'North Woods', author: 'Daniel Mason', image: 'north_woods.jpg' },
  { book_name: 'Fahrenheit 451', author: 'Ray Bradbury', image: 'fahrenheit_451.jpg' },
  { book_name: 'Война и мир', author: 'Лев Толстой', image: 'война_и_мир.jpg' },
  { book_name: 'Темная башня', author: 'Стивен Кинг', image: 'темная_башня.jpg' },
  { book_name: 'Капитанская дочка', author: 'Александр Пушкин', image: 'капитанская_дочка.jpg' },
  { book_name: 'Зов Ктулху', author: 'Говард Лавкрафт', image: 'зов_ктулзу.jpg' },
  { book_name: 'Бесы', author: 'Федор Достоевский', image: 'бесы.jpg' },
  { book_name: 'Мцыри', author: 'Михаил Лермонтов', image: 'мцыри.jpg' },
  { book_name: 'Гарри Поттер и Философский камень', author: 'Дж. Коллинз', image: 'гарри_поттер_философский_камень.jpg' },
  { book_name: 'Зов Предков', author: 'Джек Лондон', image: 'зов_предков.jpg' }
]

# Создание книг
books = book_list.map do |book|
  Book.create!(
    book_name: book[:book_name],
    author: book[:author],
    image: "/assets/#{book[:image]}",
    count: rand(1..10)
  )
end

puts "Создано #{books.count} книг"

# Создание аренды книг
rentals = books.sample(5).map do |book|
  Rental.create!(
    user: users.sample,
    book: book,
    rent_date: Faker::Date.backward(days: 14),
    collection_period: rand(7..30)
  )
end

puts "Создано #{rentals.count} записей аренды"

guest = User.find_or_create_by!(email: 'guest@example.com') do |user|
  user.password = SecureRandom.hex(8)
  user.role     = 'reader'
end
puts "Guest user: #{guest.email} (id=#{guest.id})"

# При необходимости — создаём для гостя пару аренд, если их нет
if guest.rentals.empty?
  sample_books = Book.limit(3)  # берём первые 3 книги для примера
  sample_books.each do |book|
    guest.rentals.create!(
      book:              book,
      rent_date:         Date.today,
      collection_period: 14
    )
  end
  puts "Добавлено #{guest.rentals.count} аренд для гостевого пользователя"
end