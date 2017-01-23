class ArticlesController < ApplicationController
	before_action :authenticate_user!, :only => [:new,:edit]
	
	def index
	  @articles = Article.where(status: 'Published').where(visibility: 'Public').paginate(:page => params[:page])
	  get_articles_by_month
	end

	def show
		get_articles_by_month
		get_articles_by_category
		@article = Article.find(params[:id])
		@comment = Comment.new
		@comment.commentable_id = @article.id
		impressionist(@article)
	end


	def new
		@article = Article.new()
	end

	def create
	  @article = Article.new(article_params)
	  @article.save

	  redirect_to article_path(@article)
	end

	def edit
	  @article = Article.find(params[:id])
	end

	def update
	  @article = Article.find(params[:id])
	  @article.update!(article_params)
	  flash.notice = "Article '#{@article.title}' Updated!"

	  redirect_to article_path(@article)
	end

	def destroy
		@article = Article.find(params[:id])
		@article.destroy
		 
		redirect_to articles_path
	end

	def archives
		get_articles_by_month
	end

	def feed
	    @articles = Article.all
	    respond_to do |format|
	      format.rss { render :layout => false }
	    end
	  end

	private

	def article_params
	  params.require(:article).permit(
	  	:title, 
	  	:body,
	  	:tag_list,
	  	:category_id,
	  	:counter_cache,
	  	:status,
	  	:published_at,
	  	:visibility
	  	)
	end

	def get_articles_by_month
		return @archives = Article.all.group_by{ |r| r.created_at.beginning_of_month }
	end

	def get_articles_by_category
		return @categories = Article.all.group_by{ |r| r.category.name}
	end


	def get_scheduled_articles
		Article.where(status: 'Scheduled').where('published_at == ?', Date.today)
	end

	def publish_scheduled_articles
		@articles = get_scheduled_articles
		@articles.each do |article|
			article.publish_now
		end
	end
end

