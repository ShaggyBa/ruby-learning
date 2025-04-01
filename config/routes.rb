Rails.application.routes.draw do
  get "main/index"
  get "main/help"
  get "main/contacts"
  get "main/about"
  # devise_for :users

  root to: "main#index"

  resources :books, only: [ :index, :show ]
  resources :rentals, only: [ :new, :create, :index,  :show]

  get "help", to: "main#help"
  get "contacts", to: "main#contacts"
  get "about", to: "main#about"

  # Проверка состояния сервера
  get "up", to: "rails/health#show", as: :rails_health_check
end
