Rails.application.routes.draw do

  #omniauth_callbacksコントローラーを定義することで、各SNSからの認証リクエストに対するコールバック関数を受け取れる(Rails routesで確認可)
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  devise_scope :user do
    #サインアウトを別箇で用意しないとログアウト処理ができない為記述
    get '/users/sign_out' => 'devise/sessions#destroy'
  end

  resources :signup do
    collection do
      get "session_clear"
      get 'personal'
      get 'sms'
      get 'residence'
      post "create"
      get "done"
    end
  end
end
