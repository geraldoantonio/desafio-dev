# frozen_string_literal: true

class Store < ApplicationRecord
  has_many :transactions, dependent: :destroy

  validates :name, presence: true, uniqueness: { case_sensitive: false }
  validates :owner, presence: true

  def balance
    transactions.map(&:amount).sum
  end
end
