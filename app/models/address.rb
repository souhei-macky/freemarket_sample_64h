class Address < ApplicationRecord
  belongs_to :user

  # validates :zip_code, :prefecture, :city, :number, :user_id, presence: :true
end
