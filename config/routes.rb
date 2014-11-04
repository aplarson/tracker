Rails.application.routes.draw do
  root to: 'users#index'
  
  resources :users do
    resources :goals, only: [:new, :index]
  end
  resource :session, only: [:new, :create, :destroy]
  resources :goals, except: [:new, :index]
  
end
