Rails.application.routes.draw do
  root "static_pages#top"

  # root :to => 'users#index'
  resources :users, only: %i[new create]
  resources :boards, only: %i[index new create show] do
    resources :comments, only: %i[create], shallow: true
  end

  get 'login' => 'user_sessions#new', :as => :login
  post 'login' => "user_sessions#create"
  delete 'logout' => 'user_sessions#destroy', :as => :logout
end
