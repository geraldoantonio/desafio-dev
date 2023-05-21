# frozen_string_literal: true

# file_path = 'cnab.txt'
# ParseCnabFileTransactions.call(file_path: file_path)
class ParseCnabFileTransactions
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
      file.each_line do |line|
        result = ParseCnabTransaction.call(transaction: line)
        context.fail! && break unless result.success?

        context.transactions << result.parsed_transaction
      end
    end
  end
end
