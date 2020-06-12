class AddItemToBrands < ActiveRecord::Migration[5.2]
  def change
    add_references :brands, :item, foreign_key: true
  end
end
