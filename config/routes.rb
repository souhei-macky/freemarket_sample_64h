Rails.application.routes.draw do

  #omniauth_callbacksコントローラーを定義することで、各SNSからの認証リクエストに対するコールバック関数を受け取れる(Rails routesで確認可)
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  devise_scope :user do
    #サインアウトを別箇で用意しないとログアウト処理ができない為記述
    get '/users/sign_out' => 'devise/sessions#destroy'
  end

  #トップページ
  root to: 'homes#index'

  #カテゴリ一覧用のルーティング記述(現時点では不使用)
  resources :brands_category, only: [:index, :show] 
  resources :category, only: [:index, :show] 

  #新規登録関連のルーティング記述
  resources :signup do
    collection do
      get "session_clear"
      get 'personal'
      get 'sms'
      get 'residence'
      get "done"
    end
  end
  post "signup/create" => "signup#create" #URIを取得する為作成
  
  #クレジット登録関連のルーティング記述
  resources :credit_card, only: [:new, :show, :destroy] do
    collection do
      post 'pay', to: 'credit_card#pay'
      post 'destroy', to: 'credit_card#destroy'
    end
  end


  #itemのshowアクションで商品詳細
  resources :items do
    collection do
      get 'search' => 'items#search' #検索
    end
  end

  #マイページ
  resources :mypages, only: [:index] do
    collection do
      # get 'edit', to: 'mypages#edit'#プロフィール編集用      意味不明につき残すだけ残します
      # patch 'edit', to: 'mypages#update'#プロフィール更新用      
      get 'credit' # カード情報登録
      get 'logout' #ログアウト用ページ
      get 'identification' #本人情報
      get 'profile' #プロフィール情報
    end
  end  

  #購入
  resources :transaction, only: [:index, :show] do
    collection do 
      get 'done', to: 'transaction#done'#購入完了
    end
    member do
      post 'pay', to: 'transaction#pay'#購入、支払い
    end
  end
end
