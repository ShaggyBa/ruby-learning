Rails.application.routes.draw do
  # Library рабочая зона
  get "library/", to: "library#index"
  get "library/choose_category", to: "library#choose_category"
  get "library/display_book", to: "library#display_book"

  get "library/search_books", to: "library#search_books"
  get "library/users_rentals", to: "library#users_rentals"
  get "library/user_rentals", to: "library#user_rentals"
  get "library/all", to: "library#all_books"


  # Адрес для главной страницы рабочей области
  # Пока что оставляем корневой на main#index, потом можно заменить
  # root to: "library#index"

  # CRUD ресурсы
  resources :users
  resources :rentals
  resources :books

  # Основные страницы
  get "main/index"
  get "main/help"
  get "main/contacts"
  get "main/about"

  # Текущий корневой маршрут
  root to: "main#index"

  # Псевдонимы для основных страниц
  get "help", to: "main#help"
  get "contacts", to: "main#contacts"
  get "about", to: "main#about"

  # Проверка состояния сервера
  get "up", to: "rails/health#show", as: :rails_health_check
end
