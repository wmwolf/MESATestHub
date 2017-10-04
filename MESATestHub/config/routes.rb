Rails.application.routes.draw do
  resources :tests
  root to: redirect('/tests')
end
