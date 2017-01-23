class CategoriesController < ApplicationController
	before_action :authenticate_user!, :only => [:new,:edit]

	def index
	  @categories = Category.paginate(:page => params[:page])
	end

	def show
		@category = Category.find(params[:id])
		impressionist(@category)
	end


	def new
		@category = Category.new()
	end

	def create
	  @category = Category.new(category_params)
	  @category.save

	  redirect_to category_path(@category)
	end

	def edit
	  @category = Category.find(params[:id])
	end

	def update
	  @category = Category.find(params[:id])
	  @category.update(category_params)
	  flash.notice = "'#{@category.name}' Updated!"

	  redirect_to category_path(@category)
	end

	def destroy
		@category = Category.find(params[:id])
		@category.destroy
		 
		redirect_to categories_path
	end

	private

	def category_params
	  params.require(:category).permit(
	  	:name,
	  	:parent_id,
	  	:counter_cache
	  	)
	end
end