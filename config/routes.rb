Rails.application.routes.draw do

  #omniauth_callbacksコントローラーを定義することで、各SNSからの認証リクエストに対するコールバック関数を受け取れる(Rails routesで確認可)
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  devise_scope :user do
    #サインアウトを別箇で用意しないとログアウト処理ができない為記述
    get '/users/sign_out' => 'devise/sessions#destroy'
  end

  #トップページ
  root 'homes#index'

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


  #itemのshowアクションで商品詳細
  resources :items do
    resources :chats, only: [:show]
    collection do
      get 'sell'#出品
      get 'search'#検索
    end
  end

  #マイページ
  resources :mypage, only: [:index] do
    collection do
      get '/',    to: 'mypages#index'#マイペトップ
      get 'edit', to: 'mypages#edit'#プロフィール編集用
      patch 'edit', to: 'mypages#update'#プロフィール更新用
      get 'card', to: 'mypages#card'#お支払い情報
      get 'card/new', to: 'mypages#card_new'#カード情報登録
      get 'logout', to: 'mypages#logout'#ログアウト
      get 'identification', to: 'mypages#identification'#本人情報
      get 'address', to: 'mypages#address'#お届け先住所変更
    end
  end
  #カテゴリー ,
  resources :category, only: [:index, :show] 
  resources :brands_category, only: [:index, :show] 

  #購入
  resources :transaction do
    member do
      get :buy#買う
      get :buy_complete#購入完了
      get :pay#支払う
    end
  end
end
