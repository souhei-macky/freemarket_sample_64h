class User < ApplicationRecord

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: %i[facebook google_oauth2]

  has_many :items, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_one :address, dependent: :destroy
  has_many :credit_cards, dependent: :destroy

  validates :nickname, :email, :encrypted_password, :family_name, :first_name, :family_name_kana, :first_name_kana, :year, :month, :day, presence: :true
  validates :family_name_kana, :first_name_kana, presence: :true, if: :name_kana?

  #各SNSより取得したprovider情報をauthに代入し、Userテーブル内に該当するレコードがあればuserに代入
    def self.find_for_oauth(auth)
    user = User.where(uid: auth.uid, provider: auth.provider).first
    #userがなければ新規インスタンスをハッシュ形式で作成
    unless user
      user = User.new(
        uid:      auth.uid,
        provider: auth.provider,
        email:    auth.info.email,
        nickname: auth.info.name,
      )
    end
    #userを本メソッドの返り値とする
    user
  end

  #カナカナ入力のバリデーション
  def name_kana?
    input_type = /^([ァ-ン]|ー)+$/
  end

end
