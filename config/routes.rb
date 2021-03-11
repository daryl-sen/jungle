Rails.application.routes.draw do

  resources :users
  get '/login' => 'session#new'
  post '/login' => 'session#create'
  get '/logout' => 'session#destroy'
  get '/signup' => 'users#new'
  post '/users' => 'users#create'

  root to: 'products#index'

  resources :products, only: [:index, :show]
  resources :categories, only: [:show]

  resource :cart, only: [:show] do
    post   :add_item
    post   :remove_item
  end

  resources :orders, only: [:create, :show]

  namespace :admin do
    root to: 'dashboard#show'
    get 'new_category' => 'dashboard#new_category'
    post 'create_category' => 'dashboard#create_category'
    resources :products, except: [:edit, :update, :show]
  end

  get 'about' => 'about#show'
end
