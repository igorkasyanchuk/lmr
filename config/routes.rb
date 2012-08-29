Lmr::Application.routes.draw do
  mount Forem::Engine, :at => "/forums"
  devise_for :users, :skip => [:sessions]

  as :user do
    get 'login' => 'devise/sessions#new', :as => :new_user_session
    post 'login' => 'devise/sessions#create', :as => :user_session
    match 'logout' => 'devise/sessions#destroy', :as => :destroy_user_session, :via => [:get, :delete]
  end

  namespace :admin do
    match '/', :to => 'dashboard#welcome'
    resources :pages
    resources :users
    resources :contacts, :only => [:index, :show, :destroy]
  end

  namespace :dashboard do
    match '/', :to => 'dashboard#welcome'
    resource :profile, :only => [:edit, :update]
  end

  resources :contacts, :only => [:new, :create]

  root :to => 'home#index'
end
