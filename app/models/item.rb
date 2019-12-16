class Item < ApplicationRecord
  has_many :images, dependent: :destroy

  belongs_to :user
  belongs_to :category
  belongs_to :brands_category
  belongs_to :size
  belongs_to :item_condition
end
