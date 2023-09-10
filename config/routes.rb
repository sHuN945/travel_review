Rails.application.routes.draw do
  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
    sessions: "admin/sessions"
  }
  
  scope module: :public do
    root to: 'homes#top'
    resources :comments, only: [:show, :index, :destroy]
    get 'customers/unsubscribe' => "customers#unsubscribe", as: :unsubscribe
    patch 'customers/withdrawal' => "customers#withdrawal"
    get 'customers', to: 'customers#show'
    get 'customers/edit', to: "customers#edit"
    patch 'customers', to: "customers#update"
    resources :posts, only: [:create, :destroy, :update, :index, :new, :show]
    resources :reviews, only: [:show, :edit, :update, :index, :new, :create, :destroy]
    get '/about' => "homes#about"
  end
  
  
  devise_for :customers,skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }
  
  namespace :admin do
    get '/' => "homes#top"
    resources :reviews, only: [:show, :index, :destroy]
    resources :customers, only: [:edit, :update, :show, :index]
  end
  
  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
