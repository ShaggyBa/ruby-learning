Rails.application.routes.draw do
  devise_for :users

  root to: "books#index"

  resources :books, only: [ :index, :show ]
  resources :rentals, only: [ :new, :create, :index ]

  get "help", to: "main#help"
  get "contacts", to: "main#contacts"
  get "about", to: "main#about"

  # Проверка состояния сервера
  get "up", to: "rails/health#show", as: :rails_health_check
end
