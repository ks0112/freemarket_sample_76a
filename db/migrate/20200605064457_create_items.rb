class CreateItems < ActiveRecord::Migration[5.2]
  def change
    create_table :items do |t|
      t.references :user, null: false, foreign_key: true
      t.string :name, null: false
      t.string :description, null: false
      t.string :price, null: false
      t.references :category, null: false, foreign_key: true
      t.references :brand, null: false, foreign_key: true
      t.string :status, null: false
      t.string :cost, null: false
      t.string :prefecture_id, null: false
      t.string :days, null: false
      t.timestamps
    end
  end
end
