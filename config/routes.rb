Rails.application.routes.draw do

  # ユーザー用
  devise_for :users,skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }

  scope module: :public do
    root 'homes#top'

    get 'homes/about' => 'homes#about', as: 'about'
    resources :posts, only: [:new, :create, :index, :show, :destroy]
    resources :users, only: [:show, :index, :edit]
  end

  # 運営用
  devise_for :admin, controllers: {
    sessions: "admin/sessions"
  }

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
