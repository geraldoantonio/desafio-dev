# frozen_string_literal: true

class Transaction < ApplicationRecord
  belongs_to :store

  enum kind: {
    debit: 1, boleto: 2, financing: 3, credit: 4, loan_receipt: 5,
    sales: 6, ted_receipt: 7, doc_receipt: 8, rent: 9
  }

  POSITIVE_KINDS = %w[debit credit loan_receipt sales ted_receipt doc_receipt].freeze
  NEGATIVE_KINDS = %w[boleto financing rent].freeze

  validates :kind, presence: true, inclusion: { in: kinds.keys }
  validates :occurrence_at, presence: true
  validates :cpf, presence: true
  validates :card_number, presence: true, format: { with: /\d{4}\*\*\*\*\d{4}\z/ }
  validates :amount_in_cents, presence: true, numericality: { only_integer: true }

  validate :cpf_must_be_valid

  scope :ordered_by_store_name, -> { joins(:store).order('stores.name' => :asc) }

  delegate :owner, :name, to: :store, prefix: true

  def amount
    return unless amount_in_cents.present?

    amount_in_cents / 100.0
  end

  def amount=(value)
    self.amount_in_cents = (value * 100).to_i
  end

  def amount_humanized
    return unless amount.present?

    ActiveSupport::NumberHelper.number_to_currency(
      amount * (NEGATIVE_KINDS.include?(kind) ? -1 : 1),
      unit: 'R$',
      separator: ',',
      delimiter: '.',
      negative_format: '- %u %n'
    )
  end

  def cpf_humanized
    return unless cpf.present?

    CPF.new(cpf).formatted
  end

  private

  def cpf_must_be_valid
    return if CPF.valid?(cpf)

    errors.add(:cpf, :invalid)
  end
end
