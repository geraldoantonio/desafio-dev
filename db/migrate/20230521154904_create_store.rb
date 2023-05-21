# frozen_string_literal: true

class CreateStore < ActiveRecord::Migration[7.0]
  def change
    create_table :stores do |t|
      t.string :name
      t.string :owner

      t.timestamps
    end

    add_index :stores, :name, unique: true
  end
end
