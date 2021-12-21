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
  resources :customers, only: [:edit, :update, :destroy] do
    #リレーション(kichenをフォロー)
        resource :relationships, only: [:create, :destroy]
    get 'followings' => 'relationships#followings', as: 'followings'
    get 'followers' => 'relationships#followers', as: 'followers'
    get 'my_recipe/' => 'customers#my_recipe'
    get 'my_report/' => 'customers#my_report'
    get 'receive_report/' => 'customers#receive_report'
  end
    get 'my_page/:id' => 'customers#show', as: 'my_page'
    get 'my_page/:id/edit' => 'customers#edit', as: 'edit_my_page'



  resources :lists, only: [:index, :destroy, :create, :update] do
    collection do
      delete 'lists/destroy_all' => 'lists#destroy_all'
    end
  end
  #レシピ
  resources :recipes do
    collection do
      get 'top'
      get 'get_category_children', defaults: { format: 'json' }
      get 'get_category_grandchildren', defaults: { format: 'json' }
      get 'name_search'
      get 'search/:category_id', to: 'recipes#search', as: 'search_category'
    end
    #member do
      #get 'search'
    #end
    #いいね
    resource :favorites, only: [:create, :destroy]
    #手順
    resources :explanations, only: [:create, :edit, :update, :destroy]
    #コメント
    resource :comments, only: [:create, :destroy]

    #材料詳細
    resources :material_details, only: [:new, :create]
    #作ったreport
    resources :reports, only: [:new, :index, :create, :destroy]
    resources :materials
  end
    get 'recipe/evaluation' => 'homes#evaluation'
    get 'recipe/create_at' => 'homes#create_at'
    get 'recipe/view' => 'homes#view'
    get 'favorites' => 'favorites#index', as: 'favorites'
    #post 'recipes/id/confirm' => 'recipes#confirm'
   # get 'complete' => 'recipes#compleate'
    root to: 'homes#top'
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
