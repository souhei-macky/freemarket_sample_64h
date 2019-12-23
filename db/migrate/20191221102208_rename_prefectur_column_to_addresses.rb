class RenamePrefecturColumnToAddresses < ActiveRecord::Migration[5.2]
  def change
    rename_column :addresses, :prefectur, :prefecture
  end
end
