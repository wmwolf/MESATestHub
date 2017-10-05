Rails.application.routes.draw do
  resources :test_data
  resources :test_cases
  resources :test_instances
  # resources :tests
  root to: 'visitors#index'

  get '/visitors/index', to: 'visitors#index'
end
