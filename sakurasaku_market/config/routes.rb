Rails.application.routes.draw do
  root to: "commodities#index"
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users

  resources :commodities
end
