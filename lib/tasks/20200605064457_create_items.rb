class CreateItems < ActiveRecord::Migration[5.2]
  def change
    create_table :items do |t|
      t.integer :seller_id, null: false, foreign_key: true
      t.integer :buyer_id, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.string :name, null: false
      t.string :description, null: false
      t.integer :price, null: false
      t.references :category, null: false, foreign_key: true
      t.references :brand, foreign_key: true
      t.integer :status, null: false
      t.integer :cost, null: false
      t.integer :prefecture_id, null: false
      t.integer :days, null: false
      t.timestamps
    end
  end
end
