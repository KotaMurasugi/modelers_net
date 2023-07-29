Rails.application.routes.draw do

  # ゲストユーザー用
  devise_scope :user do
    post "users/guest_sign_in", to: "users/sessions#guest_sign_in"
  end

  # ユーザー用
  devise_for :users,skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }

  scope module: :public do
    root 'homes#top'

    get 'homes/about' => 'homes#about', as: 'about'
    resources :posts, only: [:new, :create, :index, :show, :destroy] do
      resource  :favorites, only: [:create, :destroy]
      resources :comments,  only: [:create, :destroy]
      collection do
        get 'search'
      end
    end
    resources :users, only: [:show, :index, :edit, :update]
  end

  # 運営用
  devise_for :admin, skip: [:registrations, :passwords], controllers: {
    sessions: "admin/sessions"
  }

  namespace :admin do
    resources :tags, only: [:index, :edit, :create, :update, :destroy]
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
