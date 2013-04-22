Bandwagon::Application.routes.draw do
  get "tshirts_controller/new"

  authenticated :user do
    root :to => 'home#index'
  end
  root :to => "home#index"
  devise_for :users
  resources :users
  resources :tshirts do
    get :preview
  end
end
