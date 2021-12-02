Rails.application.routes.draw do

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
  resources :customers, only: [:show, :edit, :update, :delete] do
    #リレーション
        resource :relationships, only: [:create, :destroy]
    get 'followings' => 'relationships#followings', as: 'followings'
    get 'followers' => 'relationships#followers', as: 'followers'
  end

  #レシピ
  resources :recipes, only: [:new, :create, :show, :edit, :update, :delete] do
    #コメント
    resources :comments, only: [:create, :destroy]
    #いいね
    resource :favorites, only: [:create, :destroy]
  end
    post 'recipe/id/confirm' => 'recipes#confirm'
    get 'complete',   on: :collection
    root to: 'recipes#top'


  #材料詳細
  resources :material_detail, only: [:new, :create]
end

end
