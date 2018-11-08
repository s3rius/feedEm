Rails.application.routes.draw do
  resources :merchandises
  resources :order_items
  resources :orders
  resources :sellers
  resources :cards
  resources :admins
  resources :customers
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
