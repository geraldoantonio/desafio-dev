# frozen_string_literal: true

# transaction = '3201903010000014200096206760174753****3153153453JOÃO MACEDO   BAR DO JOÃO'
# ParseCnabTransaction.call(transaction: transaction)
# => {
#   kind: '3',
#   amount_in_cents: 14200,
#   cpf: '09620676017',
#   card_number: '4753****3153',
#   occurrence_at: '2019-03-01 15:34:53',
#   owner_name: 'JOÃO MACEDO',
#   store_name: 'BAR DO JOÃO'
# }
class ParseCnabTransaction
  include Interactor

  def call
    context.parsed_transaction = PARSE_TRANSACTION[context.transaction]
  rescue StandardError
    context.fail!(message: "Invalid transaction: #{context.transaction}")
  end

  PARSE_TRANSACTION = lambda do |transaction|
    {
      kind: transaction[0..0],
      amount_in_cents: transaction[9..18].to_i,
      cpf: transaction[19..29],
      card_number: transaction[30..41],
      occurrence_at: OCCURRENCE_AT[transaction],
      owner_name: transaction[48..61].strip,
      store_name: transaction[62..80].strip
    }
  end

  OCCURRENCE_AT = lambda do |transaction|
    date_string = transaction[1..8]
    time_string = transaction[42..47]

    datetime = DateTime.strptime("#{date_string} #{time_string}", '%Y%m%d %H%M%S')
    datetime.strftime('%Y-%m-%d %H:%M:%S')
  end
end
