Rails.application.routes.draw do
  get 'sessions/new'

  resources :users
  resources :sessions
  resources :computers
  resources :test_cases do
    resources :test_instances
  end

  root to: 'test_cases#index'

  # meant for remote HTTP requests
  post '/test_instances/submit', to: 'test_instances#submit'

  get 'admin', to: 'users#admin', as: 'admin'

  get 'signup', to: 'users#new', as: 'signup'
  get 'login', to: 'sessions#new', as: 'login'
  get 'logout', to: 'sessions#destroy', as: 'logout'
end
