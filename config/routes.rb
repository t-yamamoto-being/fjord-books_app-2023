Rails.application.routes.draw do
  get 'locale/:locale', to: 'application#change_locale', as: :change_locale
  
  resources :books
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "books#index"
end
