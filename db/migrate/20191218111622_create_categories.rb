class CreateCategories < ActiveRecord::Migration[5.2]
  def change
    create_table :categories do |t|
      t.string    :name,      null: false
      # 現時点では導入しておらずエラーの基となる為、実装開始まではコメントアウト化します
      # t.string    :ancestry,  null: false
      t.timestamps
    end
  end
end
