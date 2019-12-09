Rails.application.routes.draw do
  #omniauth_callbacksコントローラーを定義することで、各SNSからの認証リクエストに対するコールバック関数を受け取れる(Rails routesで確認可)
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :users do
    collection do
      get 'step1'
      get 'step2'
      get 'step3'
      get 'step4'
      get 'step5'
    end
  end
end