# frozen_string_literal: true

class Store < ApplicationRecord
  validates :name, presence: true, uniqueness: { case_sensitive: false }
  validates :owner, presence: true
end
