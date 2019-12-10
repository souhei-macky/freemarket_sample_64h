Rails.application.routes.draw do
  devise_for :users
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
