class Address < ApplicationRecord
  belongs_to :user

  # validates :zip_code, :prefectur, :city, :number, :user_id, presence: :true
end
