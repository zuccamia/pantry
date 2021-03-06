Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  get '/component', to: 'pages#component', as: 'component'

  resources :item_amounts, only: [:new, :edit, :update, :destroy]

  resources :items, only: [:new, :create]

  resources :recipes do
    resources :recipe_amounts, only: [:new, :create, :edit, :update]
    # routes for LINE bots
    get '/new_shopping_list', to: 'recipes#shopping_list', as: 'shopping_list'
  end

  resources :recipe_amounts, only: [:destroy]

  # routes for recipe API interaction
  get '/search', to: 'recipes#search', as: 'search_recipe'
  get '/view', to: 'recipes#view', as: 'view_recipe'
  get '/save', to: 'recipes#import', as: 'import_recipe'

  get '/pantry', to: 'item_amounts#index', as: 'item_amounts'
  post '/pantry', to: 'item_amounts#create'

  # routes for barcode scanning
  get '/get_barcode', to: 'item_amounts#scan_barcode', as: 'get_barcode'
  get '/add_barcode_item', to: 'item_amounts#new_barcode_item'

  # routes for LINE bots
  post '/linebot/callback', to: 'linebots#call_back'
end
