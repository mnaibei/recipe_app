Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  devise_scope :user do
    authenticated :user do
      root to: 'recipes#index', as: :authenticated_root
    end

    unauthenticated :user do
      root to: 'devise/sessions#new', as: :unauthenticated_root
    end
  end

  root 'recipes#index'
  get '/public_recipes', to: 'public_recipes#index'

  resources :users, only: %i[index show]

  resources :recipes, only: %i[index show new create destroy] do
    member do
      patch :toggle_public
    end
  end

  # get 'recipes/new', to: 'recipes#new', as: 'new_recipe'
  # post 'recipes', to: 'recipes#create'

  resources :foods, only: %i[index show new create destroy]

  resources :shopping_lists, only: [:index]
end
