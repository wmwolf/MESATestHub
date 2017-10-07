Rails.application.routes.draw do
  resources :computers
  resources :test_cases do
    resources :test_instances
  end

  root to: 'test_cases#index'

end
