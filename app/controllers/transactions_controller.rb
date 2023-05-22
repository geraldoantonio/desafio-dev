# frozen_string_literal: true

# Path: app/controllers/transactions_controller.rb
class TransactionsController < ApplicationController
  def index
    @transactions = Transaction.includes(:store).ordered_by_store_name
  end

  def import
    render :import
  end

  def import_file
    result = ImportTransactionsFromTextFile.call(file_path: params[:file])

    if result.success?
      redirect_to transactions_path, notice: result.message
    else
      flash[:error] = result.message
      render :import
    end
  end
end
