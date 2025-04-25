class RenameUrlToImageUrl < ActiveRecord::Migration[7.1]
  def change
    rename_column :tools, :url, :image_url
  end
end
