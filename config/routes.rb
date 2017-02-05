Rails.application.routes.draw do
    get 'auth/:provider/callback', to: 'sessions#create'
    get 'auth/failure', to: redirect('/')
    resources :tweets, only: [:new, :create]

	root to: 'articles#index'
	
	mount Ckeditor::Engine => '/ckeditor'
  
  	get 'sitemap/index'

    match 'author' => 'articles#author', :via => 'get'
	match 'archives' => 'articles#archives', :via => 'get'
	match 'tweeter' => 'pages#tweeter', :via => 'get'


	get 'feed' => 'articles#feed'

    get 'sitemap', :to => 'sitemap#index', :defaults => {:format => 'xml'}

	resources :articles do
		resources :comments
	end

	resources :tags
	resources :categories
	resources :sitemap, only: [:index]

	resources :comments do
		resources :comments
	end
	
	resources :pages, path: :page

	devise_for :users, controllers: { registrations: "registrations" }

	devise_scope :user do
		match 'login' => 'devise/sessions#new', :via => 'get'
		match 'logout' => 'devise/sessions#destroy', :via => 'get'
		match 'register' => 'devise/registrations#new', :via => 'get'
		match 'manage-account' => 'devise/registrations#edit', :via => 'get'
	end


end
