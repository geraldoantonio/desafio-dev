# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Store, type: :model, focus: true do
  subject(:store) { described_class.new(name: 'Example Store', owner: 'John Doe') }

  describe 'validations' do
    it 'is valid with valid attributes' do
      expect(store).to be_valid
    end

    it 'is not valid without a name' do
      store.name = nil
      expect(store).not_to be_valid
    end

    it 'is not valid without an owner' do
      store.owner = nil
      expect(store).not_to be_valid
    end

    it 'is not valid with a duplicated name' do
      described_class.create!(name: 'Example Store', owner: 'John Doe')
      expect(store).not_to be_valid
    end

    it 'is not valid with a duplicated name (case insensitive)' do
      described_class.create!(name: 'Example Store', owner: 'John Doe')
      store.name = 'example store'
      expect(store).not_to be_valid
    end
  end
end
