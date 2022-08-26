Rails.application.routes.draw do

#トップページ
root to:"public/homes#top"

#ゲストログイン処理
devise_scope :user do
  post "users/guest_sign_in" => "public/sessions#guest_sign_in", as: "guest_sign_in"
end

#会員の退会確認画面
get "users/unsubscribe/:id" => "public/users#unsubscribe", as:"unsubscribe"

#会員の退会処理（退会ステータスの更新）
patch "users/:id/withdral" => "public/users#withdral", as:"withdral"


#会員用
devise_for :users,skip: [:passwords], controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
}

#管理者用
devise_for :admin, skip: [:registrations, :passwords], controllers: {
  sessions: "admin/sessions"
}

get "users/bookmark/:id" => "public/users#bookmark", as:"bookmark" #ユーザーいいね一覧
get "users/search" => "public/users#search", as:"search" #ユーザー検索画面

scope module: :public do
  resources :users, only:[:index, :show, :edit, :update] do
    resources :notifications, only: :index
    delete "notifications" => "notifications#destroy_all"
    resource :follows, only: [:create, :destroy]
    get "followings" => "follows#followings", as:"followings" #フォローしているユーザーの一覧画面
    get "followers" => "follows#followers", as:"followers" #フォロワーの一覧画面

  end

  resources :posts do
    resource :favorites, only:[:create, :destroy]
    resources :comments, only:[:create, :destroy]
  end

end

namespace :admin do
  resources :users, only:[:index, :show, :edit, :update]
end




  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
