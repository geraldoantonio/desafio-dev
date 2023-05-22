# frozen_string_literal: true

Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  get 'transactions', to: 'transactions#index'
  get 'transactions/import', to: 'transactions#import'
  post 'transactions/import', to: 'transactions#import_file'

  root 'transactions#index'
end
