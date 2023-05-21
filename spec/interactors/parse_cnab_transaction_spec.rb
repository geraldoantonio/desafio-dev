# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ParseCnabTransaction, type: :interactor do # rubocop:disable Metrics/BlockLength
  describe '.call' do # rubocop:disable Metrics/BlockLength
    let(:transaction) { '3201903010000014200096206760174753****3153153453JOÃO MACEDO   BAR DO JOÃO' }

    subject(:context) { described_class.call(transaction:) }

    context 'when the transaction is valid' do
      it 'parses the transaction and returns the expected result' do
        expect(context).to be_success

        parsed_transaction = context.parsed_transaction
        expect(parsed_transaction).to include(
          kind: '3',
          amount_in_cents: 14_200,
          cpf: '09620676017',
          card_number: '4753****3153',
          owner_name: 'JOÃO MACEDO',
          establishment_name: 'BAR DO JOÃO'
        )

        occurrence_at = parsed_transaction[:occurrence_at]
        expect(occurrence_at).to match(/\A\d{4}-\d{2}-\d{2} \d{2}:\d{2}:\d{2}\z/)
      end
    end

    context 'when the transaction is invalid' do
      let(:transaction) { 'invalid transaction' }

      it 'returns the expected result' do
        expect(context).to be_failure
        expect(context.message).to eq('Invalid transaction')
      end

      it 'does not return a parsed transaction' do
        expect(context.parsed_transaction).to be_nil
      end
    end
  end
end
