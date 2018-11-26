Rails.application.routes.draw do
  get 'welcome/index'
  resources :merchandises
  resources :order_items
  resources :orders
  resources :sellers
  resources :cards
  resources :admins
  resources :customers
  root 'welcome#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
