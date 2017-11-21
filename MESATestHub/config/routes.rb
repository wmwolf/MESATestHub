Rails.application.routes.draw do
  get 'sessions/new'

  resources :users do
    resources :computers
  end
  resources :sessions
  resources :computers
  resources :test_cases do
    resources :test_instances
  end

  root to: 'test_cases#index', params: { version: 'latest' }

  # meant for remote HTTP requests
  post '/test_instances/submit', to: 'test_instances#submit'

  get 'admin', to: 'users#admin', as: 'admin'
  get 'admin_edit_user', to: 'users#admin_edit_user', as: 'admin_edit_user'
  delete 'admin_destroy_user', to: 'users#admin_destroy_user',
                               as: 'admin_delete_user'

  get 'signup', to: 'users#new', as: 'signup'
  get 'login', to: 'sessions#new', as: 'login'
  get 'logout', to: 'sessions#destroy', as: 'logout'

  post 'check_user', to: 'sessions#check_credentials', as: 'check_user'
  post 'check_computer', to: 'computers#check_computer', as: 'check_computer'

  # index of a particular user's computers's test instances
  get 'user/:user_id/computers/:id/test_instances',
      to: 'computers#test_instances_index',
      as: 'user_computer_test_instances'

  # global list of all computers (admins only)
  get 'all_computers', to: 'computers#index_all', as: 'all_computers'
end
