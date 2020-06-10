class AddSellerToItems < ActiveRecord::Migration[5.2]
  def change
    add_reference :items, :seller, null: false, foreign_key: true
  end
end
