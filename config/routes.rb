Rails.application.routes.draw do

  root 'members#index'

  resources :members do
    member do
      get :delete
    end
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
