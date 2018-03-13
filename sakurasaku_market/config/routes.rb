Rails.application.routes.draw do
  root to: "commodities#index"
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users

  resources :commodities
  resources :users, only: %i() do
    resources :shopping_carts, only: %i(new edit create update)
    # user が決まれば shopping_cart は決まるので url に shopping_cart 不要
    resources :commodities, only: %i() do
      resources :shopping_cart_items, only: %i(create destroy)
    end
  end
end
