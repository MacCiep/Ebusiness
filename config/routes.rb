require 'resque/server'

Rails.application.routes.draw do
  devise_for :users
  resources :offers, :rooms, :reservations, :cities, :draft_reservations
  get 'my/draft_reservations/', to: 'draft_reservations#user_scope'

  resources :payment_types, except: [:update, :show]

  authenticate :user do
    mount Resque::Server.new, at: '/jobs'
  end
end
