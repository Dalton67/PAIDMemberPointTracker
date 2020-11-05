# frozen_string_literal: true

Rails.application.routes.draw do
  get 'generalmember/index'
  root 'generalmember#index'
  get 'access/menu'
  get 'access/login'

  get 'admin', to: 'access#menu'
  post 'access/attempt_login'
  get 'access/logout'
  get 'members/bulk_create'

  resources :events

  get '/members/reset' => 'members#reset'
  get '/members/export' => 'members#export'
  get '/members/export', to: redirect('member/index')
  #match 'members/export' => 'members#export', as: :export

  resources :members do
    collection { post :import }
    collection { post :import_members_from_csv }
    collection { get :missing }
    member do
      get :delete
    end
    collection do
      get :reset_members
      get :export
    end
  end

  resources :admin_users, except: [:show] do
    member do
      get :delete
    end
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
