Rails.application.routes.draw do
  # devise
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    passwords: 'users/passwords'
  }
  
  # devise signup時のエラー解消
  get 'users' => redirect('/users/sign_up')
  
  # devise password変更時のエラー解消
  get 'users/password' => redirect('users/password/new')
  get 'users/password_reset' => redirect('users/password/edit')
  
  # homes
  root to: 'homes#top'
  get 'about' => 'homes#about'
  
  # guest_userとpasswordリセット
  devise_scope :user do
    post 'users/guest_sign_in' => 'users/sessions#guest_sign_in'
    patch 'users/password_reset' => 'users/passwords#update', as: 'user_password_reset'
  end
  
  # users
  get 'users/mypage' => 'users#show'
  get 'users/infomation/edit' => 'users#edit'
  get 'users/confirm'
  patch 'users/infomation' => 'users#update'
  delete 'users/infomation' => 'users#destroy'
  
  # recipes
  resources :recipes do
    collection do
      post 'confirm'
      get 'complete'
    end
    resource :recipe_favorites, only: [:create, :destroy]
  end
  
  # recipe_categories
  resources :recipe_categories, only: [:create]
  
  # restaurants
  resources :restaurants do
    collection do
      get 'middle_area_select'
      post 'confirm'
      get 'complete'
    end
    resource :restaurant_favorites, only: [:create, :destroy]
  end
  
  # recipe_categories
  resources :restaurant_genres, only: [:create]
  
  # search
  get 'search' => 'searches#search'
  
  # contacts
  resources :contacts, only: [:new, :create, :index]
  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
