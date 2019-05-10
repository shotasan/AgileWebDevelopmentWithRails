Rails.application.routes.draw do
  root 'store#index', as: 'store'
  resources :orders
  resources :line_items
  resources :carts
  get 'store/index'
  resources :products do
    get :who_bought, on: :member
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
