class Category < ApplicationRecord
  # 現時点では使用していないためコメントアウト化
  # has_ancestry
  has_many :items
end