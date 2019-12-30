class AddInfoToItems < ActiveRecord::Migration[5.2]
  def change
    add_column :items, :size_id, :integer, foreign_key: true
    add_column :items, :delivery_charge, :string
    add_column :items, :date, :string
  end
end