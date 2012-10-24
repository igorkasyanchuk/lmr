Lmr::Application.routes.draw do
  mount Ckeditor::Engine => '/ckeditor'

  match "/community/forums" => redirect("/community")

  mount Forem::Engine, :at => "/community"
  devise_for :users, :skip => [:sessions]

  as :user do
    get 'login' => 'sessions#new', :as => :new_user_session
    post 'login' => 'sessions#create', :as => :user_session
    match 'logout' => 'sessions#destroy', :as => :destroy_user_session, :via => [:get, :delete]
  end

  scope 'community', :as => 'community' do
    get 'admin/blocked_users', :to => 'forum#index', :as => :blocked_users
    get 'users/autocomplete', :to => "forum#autocomplete"
    post 'toggle_approve', :to => "forum#toggle_approve"
  end

  get '/users/autocomplete', :to => "admin/users#autocomplete"

  get '/log', :to => 'activities#log'

  namespace :admin do
    match '/', :to => 'dashboard#welcome'
    resource :profile, :only => [:edit, :update]
    match 'activities', :to => 'activities#index'
    resources :pages, :except => :show
    resources :service_providers, :except => :show
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
    match 'invoice', :to => 'reports#info'
    match 'payments', :to => 'reports#payments'
    match 'invoice_details', :to => 'reports#invoice_details'
    match 'service_providers', :to => 'reports#service_providers'
    get '/counters' => 'reports#counters'
    get '/counter' => 'reports#counter'
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

  get ':id', to: 'pages#show', as: :page

end
