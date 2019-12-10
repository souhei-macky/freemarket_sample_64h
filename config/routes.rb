Rails.application.routes.draw do

  #omniauth_callbacksコントローラーを定義することで、各SNSからの認証リクエストに対するコールバック関数を受け取れる(Rails routesで確認可)
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }

  # root to: "item#index"
  resources :signup do
    collection do
      get 'personal'
      get 'sms'
      get 'residence'
      post "create"
      get "done"
    end
  end
end
