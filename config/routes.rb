Rails.application.routes.draw do
  root "static_pages#top"

  # root :to => 'users#index'
  resources :users, only: %i[new create]
  resources :boards do
    resources :comments, only: %i[create update destroy], shallow: true
    collection do
			get 'bookmarks'
		end
  end
  resources :bookmarks, only: %i[create destroy]
  resource :profile, only: %i[show edit update]
  get 'login' => 'user_sessions#new', :as => :login
  post 'login' => "user_sessions#create"
  delete 'logout' => 'user_sessions#destroy', :as => :logout
end
