class CreateRatings < ActiveRecord::Migration[7.1]
  def change
    create_table :ratings do |t|
      t.references :user, null: false, foreign_key: true
      t.references :tool, null: false, foreign_key: true
      t.integer :value

      t.timestamps
    end
  end
end
