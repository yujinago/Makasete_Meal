Rails.application.routes.draw do
  # devise
  devise_for :users, controllers: {
    sessions: 'users/sessions'
  }
  
  # homes
  root to: 'homes#top'
  get 'about' => 'homes#about'
  
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
  end
  
  # recipe_categories
  resources :recipe_categories, only: [:create]
  
  # restaurants
  resources :restaurants do
    collection do
      post 'confirm'
      get 'complete'
    end
  end
  
  # recipe_categories
  resources :restaurant_genres, only: [:create]
  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
