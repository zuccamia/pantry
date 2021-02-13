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
end
