class CreateTools < ActiveRecord::Migration[7.1]
  def change
    create_table :tools do |t|
      t.string :name, null: false
      t.text :description, null: false
      t.integer :price
      t.string :condition
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
