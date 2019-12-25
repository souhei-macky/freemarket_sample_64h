class AddShoppingStatusToItems < ActiveRecord::Migration[5.2]
  def change
    add_column :items, :shopping_status, :integer
  end
end
