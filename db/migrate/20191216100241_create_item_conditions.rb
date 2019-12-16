class CreateItemConditions < ActiveRecord::Migration[5.2]
  def change
    create_table :item_conditions do |t|
      t.string :name, null: false
      t.timestamps
    end
  end
end
