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
  resources :credit_card, only: [:new, :show, :destroy] do
    collection do
      post 'pay', to: 'credit_card#pay'
      post 'destroy', to: 'credit_card#destroy'
    end
  end


  resource :homes,only: [:index] do
    resources :sells,only: [:index,:create]  do
      collection do
        resources :edit,only: [:update]  do
        end
      end
    end
  end

end
