class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :items, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_one :credit_card, dependent: :destroy
  has_one :address, dependent: :destroy

  validates :nickname, :email, :encrypted_password, :family_name, :first_name, :family_name_kana, :first_name_kana, :year, :month, :day, presence: :true
  validates :family_name_kana, :first_name_kana, presence: :true, if: :name_kana?
  
  def name_kana?
    input_type = /^([ァ-ン]|ー)+$/
  end
end
