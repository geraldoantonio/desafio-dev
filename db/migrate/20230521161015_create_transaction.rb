class CreateTransaction < ActiveRecord::Migration[7.0]
  def change
    create_table :transactions do |t|
      t.references :store, null: false, foreign_key: true
      t.string :kind
      t.datetime :occurrence_at
      t.string :cpf
      t.string :card_number
      t.integer :amount_in_cents

      t.timestamps
    end
  end
end
