class AddAddressToTools < ActiveRecord::Migration[7.1]
  def change
    add_column :tools, :address, :string
  end
end
