# frozen_string_literal: true

# file_path = 'cnab.txt'
# ImportTransactionsFromTextFile.call(file_path: file_path)
class ImportTransactionsFromTextFile
  include Interactor

  def call
    context.transactions = []
    parser_file!
  rescue StandardError => e
    context.fail!(message: 'fail to parse file', error: e.message)
  end

  private

  def parser_file!
    File.open(context.file_path, 'r') do |file|
      file.each_line { |transaction_line| save_transaction(transaction_line) }
    end
  end

  def save_transaction(transaction)
    result = ParseCnabTransaction.call(transaction:)

    if result.parsed_transaction.save
      context.transactions << result.parsed_transaction
    else
      context.fail!
    end
  end
end
