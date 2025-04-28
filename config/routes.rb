Rails.application.routes.draw do
  scope "(:locale)", locale: /ru|en/ do
    resources :sessions, only: %i[new create destroy]
    # Регистрация
    resources :users, only: %i[new create show edit update destroy]

    # Сессии (логин/логаут)
    get    '/signin',  to: 'sessions#new',     as: :signin
    post   '/signin',  to: 'sessions#create'
    delete '/signout', to: 'sessions#destroy', as: :signout

    # Library рабочая зона
    get "library/", to: "library#index"
    get "library/choose_category", to: "library#choose_category"
    get "library/display_book", to: "library#display_book"
    get "library/search_books", to: "library#search_books"
    get "library/users_rentals", to: "library#users_rentals"
    get "library/user_rentals", to: "library#user_rentals"
    get "library/all", to: "library#all_books"

    namespace :api do
      get 'library/next_book', to: 'library#next_book'
      get 'library/prev_book', to: 'library#prev_book'
    end

    # CRUD ресурсы
    resources :users
    resources :rentals
    resources :books

    # Основные страницы
    get "main/index"
    get "main/help"
    get "main/contacts"
    get "main/about"

    # Корневой маршрут
    root to: "main#index"

    # Псевдонимы для основных страниц
    get "help", to: "main#help"
    get "contacts", to: "main#contacts"
    get "about", to: "main#about"

    # Проверка состояния сервера
    get "up", to: "rails/health#show", as: :rails_health_check
  end
end
