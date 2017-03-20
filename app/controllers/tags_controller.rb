class TagsController < ApplicationController
	before_action :authenticate_user!, :except => [:index,:show]

	def index
		@tags = Tag.paginate(:page => params[:page])
	end

	def show
	  @tag = Tag.find(params[:id])
	  @articles = @tag.articles.where(status: 'Published').where(visibility: 'Public').order(published_at: :desc)
	  impressionist @tag, '', :unique => [:controller_name, :action_name, :session_hash]
	end

end
