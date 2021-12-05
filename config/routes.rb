Rails.application.routes.draw do

  namespace :customer do
    get 'reports/edit'
  end
  get 'reports/edit'
# 顧客用
# URL /customers/sign_in ...
devise_for :customers, controllers: {
  registrations: "customer/registrations",
  sessions: 'customer/sessions'
}

# 管理者用
# URL /admin/sign_in ...
devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
  sessions: "admin/sessions"
}


 #customer側↓
scope module: :customer do
  #カスタマー
  resources :customers, only: [:show, :edit, :update, :destroy] do
    #リレーション(kichenをフォロー)
        resource :relationships, only: [:create, :destroy]
    get 'followings' => 'relationships#followings', as: 'followings'
    get 'followers' => 'relationships#followers', as: 'followers'
  end
    get 'my_page/:id' => 'customers#show', as: 'my_page'
    get 'my_page/:id/edit' => 'customers#edit', as: 'edit_my_page'


  #レシピ
  resources :recipes, only: [:new, :create, :show, :edit, :update, :destroy] do
    #コメント
    resources :comments, only: [:create, :destroy]
    #いいね
    resource :favorites, only: [:create, :destroy]
    #手順
    resource :explanations, only: [:create, :edit, :update, :destroy]
    #作ったreport
    resources :reports
  end
    get 'favorites' => 'favorites#index', as: 'favorites'
    post 'recipes/id/confirm' => 'recipes#confirm'
    get 'complete' => 'recipes#compleate'
    root to: 'recipes#top'


  #材料詳細
  resources :material_details, only: [:new, :create]
end

namespace :admin do
  #トップページのルーティング

    get '/' => 'homes#top'

    #カスタマー
    resources :customers, only:[:index, :destroy]

    #材料
    resources :material_details, only:[:index, :new, :create, :edit, :update, :destroy]
end

end
