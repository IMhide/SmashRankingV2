require 'sidekiq/web'

Rails.application.routes.draw do
  mount Sidekiq::Web => '/sidekiq'

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  root 'ranking#index'
  resources :players, only: [:show] do
    resources :rankings, only: [:index, :show], module: :players
  end

  namespace :v1 do
    resources :rankings, only: [:index, :show] do
      resources :player, only: :show, module: :rankings
      resources :tournaments, only: :index, module: :rankings
    end
  end
end
