class AddImageToTools < ActiveRecord::Migration[7.1]
  def change
    add_column :tools, :url, :string
  end
end
