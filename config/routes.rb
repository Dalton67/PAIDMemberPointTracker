Rails.application.routes.draw do

  root 'members#index'
  get 'access/menu'
  get 'access/login'
  
  get 'admin', :to => 'access#menu'
  post 'access/attempt_login'
  get 'access/logout'

  resources :events 
  resources :members do
    collection {post :import}
    member do
      get :delete
    end
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
