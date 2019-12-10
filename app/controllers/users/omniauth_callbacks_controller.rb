class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController

  # Facebook用のコールバック関数定義
  def facebook
    callback_from :facebook
  end
  # Google用のコールバック関数定義
  def google_oauth2
    callback_from :google
  end

  private

  #各SNSからOAuthリダイレクトURIを受け、このメソッドが発動し、providerの引数にSNS情報が代入される
  def callback_from(provider)
    provider = provider.to_s

    #user.rbのmodelファイルに定義。
    @user = User.find_for_oauth(request.env['omniauth.auth'])
    
    #@userの値の有無によって条件分岐
    if @user.persisted?
      #コールバック関数呼び出し成功フラッシュの呼び出し、sign_in処理にリダイレクト
      flash[:notice] = I18n.t('devise.omniauth_callbacks.success', kind: provider.capitalize)
      sign_in_and_redirect @user, event: :authentication
    else
      #SNSより受け取った情報をsession["devise.#{provider}_data"]で受け取り、nicknameとemailカラムのsessionに値を代入
      session["devise.#{provider}_data"] = request.env['omniauth.auth'].except(:extra)
      session[:nickname] = session["devise.#{provider}_data"][:info][:name]
      session[:email]    = session["devise.#{provider}_data"][:info][:email]
      #sign_upのstep1ページにリダイレクト(現在は仮URLを記載)
      redirect_to new_user_registration_url
    end
  end
end
