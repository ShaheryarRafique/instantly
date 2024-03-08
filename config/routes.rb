require 'sidekiq/web'
require "sidekiq/cron/web"

Rails.application.routes.draw do
  get 'dashboard/index'
  get "/email" => 'home#email', as: :email
  devise_for :users

  root to: 'home#index'
  mount Sidekiq::Web => '/sidekiq'
end
