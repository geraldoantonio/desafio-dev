# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Transaction, type: :model do # rubocop:disable Metrics/BlockLength
  subject(:transaction) do
    described_class.new(
      store:,
      kind: 'debit',
      occurrence_at: '2019-03-01 15:34:53',
      cpf: '09620676017',
      card_number: '4753****3153',
      amount_in_cents: 14_200
    )
  end

  let(:store) { Store.create!(name: 'My Store', owner: 'Geraldo Júnior') }

  describe 'validations' do # rubocop:disable Metrics/BlockLength
    it 'is valid with valid attributes' do
      expect(transaction).to be_valid
    end

    it 'is not valid without a store' do
      transaction.store = nil
      expect(transaction).not_to be_valid
    end

    it 'is not valid without a kind' do
      transaction.kind = nil
      expect(transaction).not_to be_valid
    end

    it 'is not valid without an occurrence_at' do
      transaction.occurrence_at = nil
      expect(transaction).not_to be_valid
    end

    it 'is not valid without a cpf' do
      transaction.cpf = nil
      expect(transaction).not_to be_valid
    end

    it 'is not valid without a card_number' do
      transaction.card_number = nil
      expect(transaction).not_to be_valid
    end

    it 'is not valid without an amount_in_cents' do
      transaction.amount_in_cents = nil
      expect(transaction).not_to be_valid
    end

    it 'is not valid with an invalid kind' do
      expect { transaction.kind = 'invalid' }.to raise_error(ArgumentError)
    end

    it 'is not valid with an invalid occurrence_at' do
      transaction.occurrence_at = 'in valid'
      expect(transaction).not_to be_valid
    end

    it 'is not valid with an invalid cpf' do
      transaction.cpf = 'invalid'
      expect(transaction).not_to be_valid
    end

    it 'is not valid with an invalid card_number' do
      transaction.card_number = 'invalid'
      expect(transaction).not_to be_valid
    end

    it 'is not valid with an invalid amount_in_cents' do
      transaction.amount_in_cents = 'invalid'
      expect(transaction).not_to be_valid
    end
  end
end
