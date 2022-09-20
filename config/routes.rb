Rails.application.routes.draw do
  
  # 管理者用
  # URL /admin/sign_in ...
  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
    sessions: "admin/sessions"
  }
  
  # 顧客用
  # URL /customers/sign_in ...
  devise_for :customers,skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }
  
  devise_scope :customer do
    post 'customers/sign_up/confirm', to: 'public/registrations#confirm'
    post 'customers/sign_up/complete', to: 'public/registrations#complete'
  end
  
  root to: "public/homes#top"
  get 'about' => 'homes#about'
  namespace :public do
    patch 'customers/withdrawal/:id', to: 'customers#withdrawal', as: 'customers/withdrawal'
    get 'customers/quit', to: 'customers#quit'
    resources :customers, only:[:show, :edit, :update, :quit]
    resources :reserves, only:[:index, :new, :show]
  end
  
  namespace :admin do
    root to: "homes#top"
    resources :reserves, only:[:index, :show, :edit]
    resources :customers, only:[:index, :show, :edit, :update]
  end
  
  get   'contact', to: 'contacts#index'     # 入力画面
  post  'contact/confirm', to: 'contacts#confirm'   # 確認画面
  post  'contact/thanks', to: 'contacts#thanks'    # 送信完了画面
  
  resources :maps, only:[:index]
  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
