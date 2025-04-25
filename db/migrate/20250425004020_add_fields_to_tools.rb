class AddFieldsToTools < ActiveRecord::Migration[7.1]
  def change
    add_column :tools, :tool_price, :decimal, precision: 8, scale: 2
    add_column :tools, :condition, :string
    add_reference :tools, :owner, foreign_key: { to_table: :users }, null: true
  end
end
