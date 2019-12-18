class CreateItems < ActiveRecord::Migration[5.2]
  def change
    create_table :items do |t|
      t.string  :name,              null: false
      t.text    :description,       null: false
      t.integer :price,             null: false
      t.integer :shopping_status,   null: false
      t.integer :user_id,           null: false,  foreign_key: true
      t.integer :category_id,       null: false,  foreign_key: true
      t.integer :brands_category_id,              foreign_key: true
      t.integer :size_id,           null: false,  foreign_key: true
      t.integer :item_condition_id, null: false,  foreign_key: true
      t.timestamps
    end
  end
end
