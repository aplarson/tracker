Rails.application.routes.draw do
  root to: 'users#index'
  
  resources :users do
    resources :goals, only: [:new]
  end
  resource :session, only: [:new, :create, :destroy]
  resources :goals, except: [:new]
  
end
