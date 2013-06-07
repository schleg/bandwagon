Bandwagon::Application.routes.draw do
  authenticated :user do
    root :to => 'home#index'
  end
  devise_for :users
  resources :users
  resources :tshirts do
    get :preview
  end
  namespace :admin do
    resources :tshirts
  end
  root :to => "home#index"
end
