class Item < ApplicationRecord
  has_many :images, dependent: :destroy
  accepts_nested_attributes_for :images
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy
  belongs_to :user
  belongs_to :category
  belongs_to :brands_category
  belongs_to :size, optional: true
  belongs_to :item_condition
  
end
