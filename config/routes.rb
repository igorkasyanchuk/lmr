Lmr::Application.routes.draw do
  mount Ckeditor::Engine => '/ckeditor'

  mount Forem::Engine, :at => "/forums"
  devise_for :users, :skip => [:sessions]

  as :user do
    get 'login' => 'devise/sessions#new', :as => :new_user_session
    post 'login' => 'devise/sessions#create', :as => :user_session
    match 'logout' => 'devise/sessions#destroy', :as => :destroy_user_session, :via => [:get, :delete]
  end
  
  get '/forums/admin/users_list', :to => 'forum#index'
  get '/forums/users/autocomplete', :to => "forum#autocomplete"
  post 'forums/toggle_approve', :to => "forum#toggle_approve"

  get '/users/autocomplete', :to => "admin/users#autocomplete"

  get '/log', :to => 'activities#log'

  namespace :admin do
    match '/', :to => 'dashboard#welcome'
    resource :profile, :only => [:edit, :update]
    match '/activities', :to => 'activities#index'
    resources :pages, :except => :show
    resources :users do
      member do 
        get :confirm
        get :block
        get :unblock
        get :time_unblock
      end
    end
    resources :contacts, :only => [:index, :show, :destroy]
    resources :page_parts, :only => [:index, :edit, :update]
    resources :posts
  end


  namespace :dashboard do
    match '/', :to => 'dashboard#welcome'
    match '/info', :to => 'reports#info'
    resource :profile, :only => [:edit, :update]
  end

  namespace :news do
    resources :posts, :only => [:index, :show]
    match '/', :to => 'posts#index'
    match '/atom', :controller => 'feed', :action => "atom"
    match '/rss', :controller => 'feed', :action => "rss"
  end

  resources :contacts, :only => [:new, :create]

  resources :pages, :only => :show
  

  root :to => 'home#index'
  match 'site_search', :to => 'application#site_search'

end
