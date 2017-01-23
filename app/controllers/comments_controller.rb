class CommentsController < ApplicationController
	before_action :authenticate_user!, :only => [:create]
	
	before_action :find_commentable

	def create
	  @comment = @commentable.comments.new(comment_params)

	 if @comment.save
        redirect_to :back, notice: 'Your comment was successfully posted!'
      else
        redirect_to :back, notice: "Your comment wasn't posted!"
      end

	  # redirect_to article_path(@comment.article)
	end

	def comment_params
	  params.require(:comment).permit(:author_name, :body, :media)
	end

	def find_commentable
      @commentable = Comment.find_by_id(params[:comment_id]) if params[:comment_id]
      @commentable = Article.find_by_id(params[:article_id]) if params[:article_id]
    end
end
