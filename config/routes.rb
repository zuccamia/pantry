Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  get '/component', to: 'pages#component', as: 'component'

  resources :item_amounts, only: [:new, :edit, :update, :destroy]

  resources :items, only: [:new, :create]

  resources :recipes do
    resources :recipe_amounts, only: [:new, :create]
  end

  resources :recipe_amounts, only: [:destroy]

  # routes for recipe API interaction
  get '/search', to: 'recipes#search', as: 'search_recipe'
  get '/view', to: 'recipes#view', as: 'view_recipe'
  get '/save', to: 'recipes#import', as: 'import_recipe'

  get '/pantry', to: 'item_amounts#index', as: 'item_amounts'

  # routes for barcode scanning
  get '/getbarcode', to: 'item_amounts#scan_barcode', as: 'scan_barcode'
end
