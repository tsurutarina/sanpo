Rails.application.routes.draw do

  devise_for :admin, skip: [:registrations, :passwords], controllers: {
    sessions: "admin/sessions"
  }

  devise_for :customers, skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: "public/sessions"
  }
  # ゲストログイン
  devise_scope :customer do
    post "public/guest_sign_in" => "public/sessions#guest_sign_in"
  end

  scope module: :public do
    root to: "homes#top"
    get "/about" => "homes#about", as: 'about'
    resources :customers, only: [:show, :edit, :update] do
      resource :relationships, only: [:create, :destroy]
      get "followings" => "relationships#followings", as: "followings"
      get "followers" => "relationships#followers", as: "followers"
    end
    resources :spots, only: [:index, :create] do
      resources :posts, only: [:index, :show, :create, :destroy]
    end
    resources :posts, except: [:show, :new, :index, :edit, :create, :update, :destroy] do
      resources :post_comments, only: [:create, :destroy]
      resource :favorites, only: [:create, :destroy]
    end
    get "search" => "searches#search"
  end

  namespace :admin do
    root to: "homes#top"
    resources :customers, only: [:show, :edit, :update]
    resources :spots, only: [:index, :destroy]
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
