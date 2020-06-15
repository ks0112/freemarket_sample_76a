class CreateBrands < ActiveRecord::Migration[5.2]
  def change
    create_table :brands do |t|
      t.string :name, index: true
      t.timestamps
      t.integer :item_id, foreign_key: true
    end
  end
end