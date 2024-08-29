Rails.application.routes.draw do
  resources :transactions
  devise_for :users

  root to: 'pages#home'
  get 'profile', to: 'pages#profile'
  get 'about', to: 'pages#about'
  get 'report', to: 'pages#report'
  get 'transaction', to: 'pages#transaction'
  
end
