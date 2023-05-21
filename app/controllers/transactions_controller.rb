# frozen_string_literal: true

# Path: app/controllers/transactions_controller.rb
class TransactionsController < ApplicationController
  def index
    @transactions = Transaction.includes(:store).ordered_by_store_name
  end

  def import
    result = ImportTransactionsFromTextFile.call(file_path: params[:file])

    redirect_to transactions_path, notice: result.message
  end
end
