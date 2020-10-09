Rails.application.routes.draw do

  get 'generalmember/index'
  root 'members#index'
  get 'access/menu'
  get 'access/login'

  get 'admin', :to => 'access#menu'
  post 'access/attempt_login'
  get 'access/logout'

  resources :events

  get '/members/reset' => 'members#reset'

  resources :members do
    collection {post :import}
    collection {get :missing}
    member do
      get :delete
    end
    collection do
      get :reset_members
    end
  end

  resources :admin_users, :except => [:show] do
    member do
      get :delete
    end
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
