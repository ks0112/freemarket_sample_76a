class CreateItems < ActiveRecord::Migration[5.2]
  def change
    create_table :items do |t|
      t.integer :buyer_id, foreign_key: true
      t.integer :seller_id, null: false, foreign_key: true
      t.string :name, null: false
      t.string :description, null: false
      t.integer :price, null: false
      t.integer :category_id, null: false, foreign_key: true
      t.integer :brand_id, foreign_key: true
      t.integer :status_id, null: false
      t.integer :cost_id, null: false
      t.integer :prefecture_id, null: false
      t.integer :days_id, null: false
      t.timestamps
    end
  end
end