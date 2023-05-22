# frozen_string_literal: true

# transaction = '3201903010000014200096206760174753****3153153453JOÃO MACEDO   BAR DO JOÃO'
# ParseCnabTransaction.call(transaction: transaction)
# => Transaction:0x00007f8b6c0b6a10
#   kind: 3,
#   amount_in_cents: 14200,
#   cpf: '09620676017',
#   card_number: '4753****3153',
#   occurrence_at: '2019-03-01 15:34:53',
#   store: {
#     name: 'BAR DO JOÃO',
#     owner: 'JOÃO MACEDO'
#   }
# }
class ParseCnabTransaction
  include Interactor

  def call
    transaction = build_transaction(PARSE_TRANSACTION[context.transaction])

    if transaction.valid?
      context.parsed_transaction = transaction
    else
      context.fail!(message: transaction.errors.full_messages.to_sentence)
    end
  rescue StandardError
    context.fail!(message: "Invalid transaction: #{context.transaction}")
  end

  def build_transaction(params)
    Transaction.find_or_create_by(
      params.except(:store).merge(store: build_store(params[:store]))
    )
  end

  def build_store(params)
    Store.find_or_create_by(params)
  end

  PARSE_TRANSACTION = lambda do |transaction|
    {
      kind: transaction[0].to_i,
      amount_in_cents: transaction[9..18].to_i,
      cpf: transaction[19..29],
      card_number: transaction[30..41],
      occurrence_at: OCCURRENCE_AT[transaction],
      store: {
        name: transaction[62..80].strip,
        owner: transaction[48..61].strip
      }
    }
  end

  OCCURRENCE_AT = lambda do |transaction|
    date_string = transaction[1..8]
    time_string = transaction[42..47]

    datetime = DateTime.strptime("#{date_string} #{time_string}", '%Y%m%d %H%M%S')
    datetime.strftime('%Y-%m-%d %H:%M:%S')
  end
end
