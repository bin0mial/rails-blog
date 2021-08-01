Rails.application.routes.draw do

  root "posts#index"

  namespace :api do
    namespace :v1 do
      resources :posts, only: %w[ index show]
    end
  end

  resources :posts

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
