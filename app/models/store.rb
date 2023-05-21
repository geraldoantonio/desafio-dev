# frozen_string_literal: true

class Store < ApplicationRecord
  has_many :transactions, dependent: :destroy

  validates :name, presence: true, uniqueness: { case_sensitive: false }
  validates :owner, presence: true

  scope :by_name, ->(name) { where('lower(name) = ?', name.downcase).first }
end
