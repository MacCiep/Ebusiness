require 'resque/server'

Rails.application.routes.draw do
  devise_for :users
  resources :offers, :rooms, :reservations

  authenticate :user do
    mount Resque::Server.new, at: '/jobs'
  end
end
