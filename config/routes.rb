Rails.application.routes.draw do
  root "static_pages_controller#top"

  # root :to => 'users#index'
  resources :users, only: %i[new create]

  get 'login' => 'user_sessions#new', :as => :login
  post 'login' => "user_sessions#create"
  delete 'logout' => 'user_sessions#destroy', :as => :logout
end
