require 'resque/server'

Rails.application.routes.draw do
  devise_for :users
  resources :offers, :rooms, :reservations, :cities, :draft_reservations
  get 'my/draft_reservations/', to: 'draft_reservations#user_scope'
  get 'my/reservations/', to: 'reservations#show_user_scope'

  resources :payment_types, except: [:update, :show]

  authenticate :user do
    mount Resque::Server.new, at: '/jobs'
  end

  namespace :admin do
    post 'users/block/:id', to: 'users#block'
    post 'users/unblock/:id', to: 'users#unblock'
    get 'users/all', to: 'users#index'
    delete 'offers/:id', to: 'offers#destroy'
  end
end
