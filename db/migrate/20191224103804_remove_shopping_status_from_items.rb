class RemoveShoppingStatusFromItems < ActiveRecord::Migration[5.2]
  def change
    remove_column :items, :shopping_status, :integer
  end
end
