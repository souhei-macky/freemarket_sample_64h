Rails.application.routes.draw do

  #omniauth_callbacksコントローラーを定義することで、各SNSからの認証リクエストに対するコールバック関数を受け取れる(Rails routesで確認可)
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  devise_scope :user do
    get'/users/sign_out' => 'devise/sessions#destroy'
  end

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
  resources :credit_card, only: [:new, :show, :destroy] do
    collection do
      post 'pay', to: 'credit_card#pay'
      post 'destroy', to: 'credit_card#destroy'
    end
  end
  resources :items,only:[:index, :show] do
    collection do
      get 'search'
    end
  end
end
