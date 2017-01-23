class TagsController < ApplicationController
	before_action :authenticate_user!, :only => [:new,:edit]

	def index
		@tags = Tag.paginate(:page => params[:page])
	end

	def show
	  @tag = Tag.find(params[:id])
	  impressionist @tag, '', :unique => [:controller_name, :action_name, :session_hash]
	end

end
