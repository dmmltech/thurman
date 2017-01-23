Rails.application.routes.draw do
  get 'sitemap/index'

	root to: 'articles#index'

	match 'archives' => 'articles#archives', :via => 'get'

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

	devise_for :users

	devise_scope :user do
		match 'login' => 'devise/sessions#new', :via => 'get'
		match 'logout' => 'devise/sessions#destroy', :via => 'get'
		match 'register' => 'devise/registrations#new', :via => 'get'
		match 'manage-account' => 'devise/registrations#edit', :via => 'get'
	end


end
