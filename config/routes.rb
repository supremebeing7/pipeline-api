Rails.application.routes.draw do
  resources :deals, only: :index

  root to: 'deals#index'
end
