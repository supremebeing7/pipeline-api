Rails.application.routes.draw do
  resources :deals, only: :index
end
