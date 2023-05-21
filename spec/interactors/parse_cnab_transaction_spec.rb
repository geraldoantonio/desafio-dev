# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ParseCnabTransaction, type: :interactor do
  describe '.call' do
    let(:transaction) { '3201903010000014200096206760174753****3153153453JOÃO MACEDO   BAR DO JOÃO' }

    subject(:context) { described_class.call(transaction:) }

    context 'when the transaction is valid' do
      it 'parses the transaction and returns valid transaction' do
        expect(context).to be_success

        parsed_transaction = context.parsed_transaction
        expect(parsed_transaction).to be_a(Transaction)
      end
    end

    context 'when the transaction is invalid' do
      let(:transaction) { 'invalid transaction' }

      it 'returns the expected result' do
        expect(context).to be_failure
        expect(context.message).to eq('Invalid transaction: invalid transaction')
      end

      it 'does not return a parsed transaction' do
        expect(context.parsed_transaction).to be_nil
      end
    end
  end
end
