Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  get '/component', to: 'pages#component', as: 'component'

  resources :item_amounts, only: [:index, :edit, :update, :destroy]

  resources :items, only: [:new, :create]

  resources :recipes, only: [:index, :show, :new, :create, :destroy] do
    resources :recipe_amounts, only: [:new, :create]
  end

  resources :recipe_amounts, only: [:destroy]

  # routes for recipe API interaction
  get '/search', to: 'recipes#search', as: 'search_recipe'
  get '/view', to: 'recipes#view', as: 'view_recipe'
  get '/save', to: 'recipes#import', as: 'import_recipe'

  get '/category', to: 'categories#index', as: 'pantry'
end
