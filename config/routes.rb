require 'sidekiq/web'

Rails.application.routes.draw do

  root to: 'campaigns#index'

  resources :campaigns, only: [:index, :show]

  mount Sidekiq::Web => '/sidekiq'

end
