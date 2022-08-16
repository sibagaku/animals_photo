Rails.application.routes.draw do

#トップページ
root to:"public/homes#top"

#ゲストログイン処理
devise_scope :public do
  post "users/guest_sign_in" => "public/sessions#new_guest", as:"new_guest"
end

#会員の退会確認画面
get "users/unsubscribe" => "public/users#unsubscribe", as:"unsubscribe"

#会員の退会処理（退会ステータスの更新）
patch "users/withdral" => "public/users#withdral", as:"withdral"


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
get "users/follow" => "public/users#follow", as:"follow" #会員がフォローしているユーザーの一覧画面
get "users/follower" => "public/users#follower", as:"follower" #あるユーザーをフォローしているユーザー（フォロワー）の一覧画面
get "users/search" => "public/users#search", as:"search" #ユーザー検索画面

scope module: :public do
  get "users/notification", as:"notification" #ユーザーの通知一覧画面
  resources :users, only:[:index, :show, :edit, :update]
  resources :posts do
    resources :comments, only:[:create, :destroy]
  end
end

namespace :admin do
  resources :users, only:[:index, :show, :edit, :update]
end




  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
