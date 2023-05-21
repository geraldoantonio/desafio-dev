class KindChangeColumnType < ActiveRecord::Migration[7.0]
  def change
    change_column :transactions, :kind, :integer, using: 'kind::integer'
  end
end
