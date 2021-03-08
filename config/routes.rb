Rails.application.routes.draw do

  root to: "tweets#index"

  devise_for :users
  resources :tweets do
    resources :comments, except: [:index]
  end
  resources :likes, only: [:create]
  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
