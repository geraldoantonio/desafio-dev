# frozen_string_literal: true

Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  get 'stores', to: 'stores#index'
  get 'stores/:id/transactions', to: 'stores#transactions', as: 'store_transactions'
  get 'transactions/import', to: 'transactions#import'
  post 'transactions/import', to: 'transactions#import_file'

  root 'stores#index'
end
