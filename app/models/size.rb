class Size < ApplicationRecord
  belongs_to :item, optional: true
end
