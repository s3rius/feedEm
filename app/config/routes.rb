Rails.application.routes.draw do
  devise_for :customers
  devise_for :admins
  get 'search_api/search'
  get 'welcome/merch'
  get 'welcome/sellers'
  resources :merchandises
  resources :order_items
  resources :orders
  resources :sellers
  resources :cards
  resources :admins
  resources :customers
  root 'welcome#merch'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
