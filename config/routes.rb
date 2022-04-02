require 'resque/server'

Rails.application.routes.draw do
  devise_for :users
  resources :offers, :rooms, :reservations, :cities

  authenticate :user do
    mount Resque::Server.new, at: '/jobs'
  end
end
