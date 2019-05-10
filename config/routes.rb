Rails.application.routes.draw do
  root 'store#index', as: 'store'
  get 'admin/index'
  get 'store/index'
  controller :sessions do
    get 'login', action: :new
    post 'login', action: :create
    delete 'logout', action: :destroy
  end
  resources :users
  resources :orders
  resources :line_items
  resources :carts
  resources :products do
    get :who_bought, on: :member
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
