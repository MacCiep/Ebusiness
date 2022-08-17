require 'resque/server'

Rails.application.routes.draw do
  devise_for :users, controllers: { sessions: 'users/sessions' }
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
    post 'users/make_admin/:id', to: 'users#make_admin'
    get 'users/all', to: 'users#index'
    delete 'offers/:id', to: 'offers#destroy'
  end
end
