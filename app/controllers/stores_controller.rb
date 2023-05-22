# frozen_string_literal: true

# Path: app/controllers/stores_controller.rb
class StoresController < ApplicationController
  def index
    @stores = Store.all
  end

  def transactions
    @transactions = store.transactions
  end

  private

  def store
    @store ||= Store.find(params[:id])
  end
end
