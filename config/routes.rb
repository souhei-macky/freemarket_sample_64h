Rails.application.routes.draw do
  devise_for :users
  # root to: "item#index"
  resources :signup do
    collection do
      get 'step1'
      get 'step2'
      get 'step3'
      post "create"
      get "done"
    end
  end
end
