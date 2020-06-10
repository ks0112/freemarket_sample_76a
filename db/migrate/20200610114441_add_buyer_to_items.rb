class AddBuyerToItems < ActiveRecord::Migration[5.2]
  def change
    add_reference :items, :buyer, foreign_key: true
  end
end
