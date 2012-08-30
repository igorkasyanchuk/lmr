Lmr::Application.routes.draw do
  mount Ckeditor::Engine => '/ckeditor'

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
    resources :page_parts, :only => [:index, :edit, :update]
    resources :posts
  end


  namespace :dashboard do
    match '/', :to => 'dashboard#welcome'
    resource :profile, :only => [:edit, :update]
  end

  namespace :news do
    resources :posts, :only => [:index, :show]
    match '/', :to => 'posts#index'
    match '/atom', :controller => 'feed', :action => "atom"
    match '/rss', :controller => 'feed', :action => "rss"
  end

  resources :contacts, :only => [:new, :create]
  
  match 'pages/:id' => 'pages#show', :as => :page

  root :to => 'home#index'

end
