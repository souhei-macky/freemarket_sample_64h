class User < ApplicationRecord

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: %i[facebook twitter google_oauth2]

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

end
