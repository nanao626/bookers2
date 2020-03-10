Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'books#home'
  resources :books
  resources :users
  get 'home' => 'books#home'
  get 'home/about' => 'books#about'
  # get "login" =>"users#login_from"
  # post "logout" =>"users#login_from"
  resources :users, only: [:show, :edit]
end
