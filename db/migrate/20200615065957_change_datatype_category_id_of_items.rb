class ChangeDatatypeCategoryIdOfItems < ActiveRecord::Migration[5.2]
  def change
    rename_column :items, :category_id, :category
    change_column :items, :category, :references, :null: false, :foreign_key: true
  end
end
