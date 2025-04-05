Rails.application.routes.draw do
  resources :users
  resources :rentals
  resources :books

  get "main/index"
  get "main/help"
  get "main/contacts"
  get "main/about"

  root to: "main#index"

  get "help", to: "main#help"
  get "contacts", to: "main#contacts"
  get "about", to: "main#about"

  # Проверка состояния сервера
  get "up", to: "rails/health#show", as: :rails_health_check
end
