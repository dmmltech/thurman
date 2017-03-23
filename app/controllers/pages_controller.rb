class PagesController < ApplicationController
	before_action :authenticate_user!, :except => [:show,:thurman]
	before_action :authorize_can_view, :only => [:show]

	def index 
		@pages = Page.paginate(:page => params[:page])
		authorize! :read, @page
	end

	def show
		@page = Page.find(params[:id])
		impressionist @page, '', :unique => [:controller_name, :action_name, :session_hash]
	end

	def tweeter
		authorize! :manage, @page
	end

	def thurman
		render :layout => "full"
	end

	def new
		@page = Page.new
		authorize! :create, @page
	end

	def create
		authorize! :create, @page
		@page = Page.create(page_params)
		@page.save
	    redirect_to page_path(@page)
	end

	def edit
		@page = Page.find(params[:id])
		authorize! :update, @page
	end

	def update
		authorize! :update, @page
	  @page = Page.find(params[:id])
	  @page.update!(page_params)
	  flash.notice = "Page '#{@page.title}' Updated!"
	  redirect_to page_path(@page)
	end

	def destroy
		@page = Page.find(params[:id])
		@page.destroy
		redirect_to pages_path
		authorize! :delete, @page
	end

	private

	def authorize_can_view
		@page = Page.find(params[:id])
		if @page.visibility == 'Private' || @page.visibility ==  'Hidden'|| @page.status ==  'Draft' || @page.status ==  'Scheduled'
			if current_user
				redirect_to pages_path unless current_user.has_any_role? :author, :admin, :editor
		    #redirects to previous page
		  else
		  	redirect_to login_path
		  end
	  end
	end

	def page_params
	  params.require(:page).permit(
	  	:title, 
	  	:body,
		:published_at,
		:visibility,
		:slug,
		:status,
		:order,
		:parent_id,
		:counter_cache,
		:image,
		:menu,
		:seotitle,
  	:seodescription,
  	:menuslug
	  	)
	end

end