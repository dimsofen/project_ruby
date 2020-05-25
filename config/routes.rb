Rails.application.routes.draw do
  root 'staic_page#home'
  resources :posts do
    resources :comments
  end
  resources :posts do
    resources :likes
  end
  resources :relationships, only: [:create, :destroy]

  get '/singup', to:'users#new'
  get '/login', to: "sessions#new"
  post '/login', to: "sessions#create"
  get '/logout', to: 'sessions#destroy'

  resources :users do
    member do
    get :following, :followers
    end
    end
    mount Commontator::Engine => '/commontator'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
