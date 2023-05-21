# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ImportTransactionsFromTextFile, type: :interactor do
  let(:file_path) { 'spec/fixtures/files/cnab.txt' }
  subject(:context) { ImportTransactionsFromTextFile.call(file_path:) }

  describe '.call' do
    context 'when given a valid file' do
      it 'succeeds' do
        expect(context).to be_a_success
      end

      it 'provides a list of transactions' do
        expect(context.transactions).to be_a(Array)
        expect(context.transactions.size).to eq(21)
      end
    end

    context 'when given an invalid file' do
      let(:file_path) { 'spec/fixtures/files/invalid.txt' }
      subject(:context) { ImportTransactionsFromTextFile.call(file_path:) }

      it 'fails' do
        expect(context).to be_a_failure
      end

      it 'provides a failure message' do
        expect(context.message).to eq('fail to parse file')
      end
    end
  end
end
