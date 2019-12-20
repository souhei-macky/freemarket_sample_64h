class Category < ApplicationRecord
  # 現時点では使用していないためコメントアウト化
  # has_ancestry
  belongs_to :item
end
