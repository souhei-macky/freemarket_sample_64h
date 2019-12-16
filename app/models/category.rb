class Category < ApplicationRecord
  # 一旦、ジェムを入れるまで仮の紐付け
  has_many :items
end
