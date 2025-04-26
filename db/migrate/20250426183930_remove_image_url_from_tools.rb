class RemoveImageUrlFromTools < ActiveRecord::Migration[7.1]
  def change
    remove_column :tools, :image_url, :string
  end
end
