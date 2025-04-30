class RemovePriceFromTools < ActiveRecord::Migration[7.1]
  def change
    remove_column :tools, :price, :integer
  end
end
