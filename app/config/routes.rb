Rails.application.routes.draw do
  match 'api/v1/addOrder' => 'orders#add_order', :via => :post
  match 'api/v1/readyOrder' => 'orders#order_ready', :via => :post
  match 'api/v1/closeOrder' => 'orders#order_close', :via => :post
  get 'api/v1/getMyCards', to: 'cards#get_customer_cards'
  get 'cart/show'
  get 'search/show'
  get 'search/search'
  get 'seller_sessions/new'
  match 'seller_sessions/create' => 'seller_sessions#create', :via => :post
  match 'seller_sessions/destroy' => 'seller_sessions#destroy', :via => :delete
  devise_for :customers
  devise_for :admins
  get 'search_api/search'
  get 'welcome/merch'
  get 'welcome/sellers'
  resources :merchandises
  resources :order_items
  resources :orders
  post '/sellers/liked/:id', to: 'sellers#liked'
  post '/sellers/disliked/:id', to: 'sellers#disliked'
  resources :sellers
  resources :cards
  resources :admins
  resources :customers
  root 'welcome#merch'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
