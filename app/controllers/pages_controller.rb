class PagesController < ApplicationController
	before_action :authenticate_user!, :only => [:new,:edit]

	def index 
		@pages = Page.paginate(:page => params[:page])
	end

	def show
		@page = Page.find(params[:id])
		impressionist(@page)
	end

	def new
		@page = Page.new
	end

	def create
		@page = Page.create(page_params)
		@page.save
	    redirect_to page_path(@page)
	end

	def update
	  @page = Page.find(params[:id])
	  @page.update!(page_params)
	  flash.notice = "Page '#{@page.title}' Updated!"

	  redirect_to page_path(@page)
	end

	def destroy
		@page = Page.find(params[:id])
		@page.destroy
		redirect_to pages_path
	end

	private

	def page_params
	  params.require(:page).permit(
	  	:title, 
	  	:body,
		:published_at,
		:slug,
		:status,
		:order,
		:parent_id,
		:counter_cache
	  	)
	end

end