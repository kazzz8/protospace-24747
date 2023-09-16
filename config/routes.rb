Rails.application.routes.draw do
  devise_for :users
  root to: 'prototypes#index'
  resources :prototypes do
    resources :comments, only: :create
  end
  resources :users, only: :show
  #ネストさせることによってprototypeとcommensを関連づけることができる
  #ネストさせない場合　/comments(.:format)
  #ネストさせる場合　　/prototypes/:prototype_id/comments(.:format)
end
