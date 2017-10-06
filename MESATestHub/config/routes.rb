Rails.application.routes.draw do
  resources :computers
  resources :test_data
  resources :test_cases
  resources :test_instances
  # resources :tests
  root to: 'test_cases#index'

  # get '/visitors/index', to: 'visitors#index'
end
