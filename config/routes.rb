Rails.application.routes.draw do
	mount Ckeditor::Engine => '/ckeditor'
	
  get 'contacts/index'

  get 'contacts/new'

  get 'auth/:provider/callback', to: 'sessions#create'
  get 'auth/failure', to: redirect('/')
  resources :tweets, only: [:new, :create]

	root to: 'articles#index'
  
  get 'sitemap/index'

  match 'leads' => 'contacts#manage', :via => 'get'
  match 'thurman' => 'pages#thurman', :via => 'get'
  match 'author' => 'articles#author', :via => 'get'
	match 'archives' => 'articles#archives', :via => 'get'
	match 'editorial' => 'articles#editorial', :via => 'get'
	match 'tweeter' => 'pages#tweeter', :via => 'get'

	get 'feed' => 'articles#feed'

	resources :contacts, path: :mailing, only: [:index, :create]

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

	resources :users

	get '/:id' => "shortener/shortened_urls#show"


end
