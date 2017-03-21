class UsersController < ApplicationController
	before_action :authenticate_user!

	def index
		@users = User.with_role(:author)
	end

	def show
		@user = User.find(params[:id])
		return @articles = Article.where(user_id: @user.id).where(status: 'Published').where(visibility: 'Public').order(published_at: :desc)
	end
	
end
