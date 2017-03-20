class ArticlesController < ApplicationController
	before_action :authenticate_user!, :only => [:new,:edit,:create,:update,:destroy,:delete]
	
	def index
	  @articles = Article.where(status: 'Published').where(visibility: 'Public').order(published_at: :desc).paginate(:page => params[:page])
	  get_articles_by_month
	end

	def show
		get_articles_by_month
		@categories = Category.all
		@article = Article.find(params[:id])
		@comment = Comment.new
		@comment.commentable_id = @article.id
		impressionist @article, '', :unique => [:controller_name, :action_name, :session_hash]
	end


	def new
		@article = Article.new()
		# authorize! :create, @article
	end

	def create
	  @article = Article.new(article_params)
	  @article.save

	  publish_to_twitter?
	  redirect_to article_path(@article)
	end

	def edit
	  @article = Article.find(params[:id])
	  # authorize! :update, @article
	end

	def update
	  @article = Article.find(params[:id])
	  @article.update!(article_params)
	  publish_to_twitter?
	  redirect_to article_path(@article)
	  flash.notice = "Article '#{@article.title}' Updated!"
	rescue Twitter::Error => e
	  flash.notice = "Twitter status not sent-#{e.message}"
	  redirect_to article_path(@article)
	  
	end

	def destroy
		@article = Article.find(params[:id])
		@article.destroy
		redirect_to articles_path
		# authorize! :delete, @article
	end

	def archives
		get_articles_by_month
	end

	def editorial
		get_editorial_calendar
	end

	def author
		get_articles_by_author
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
	  	:visibility,
	  	:user_id,
	  	:image
	  	)
	end

	def publish_to_twitter?
		if params[:twitter] == 'Yes'
			url = Shortener::ShortenedUrl.generate(article_url(@article)).unique_key
			params[:tweet] != ''  ? current_user.tweet(params[:tweet]) : current_user.tweet(@article.title + ' via ' + root_url + url)
		end
	end

	def get_editorial_calendar
		return @archives = Article.where(visibility: 'Public').order(published_at: :asc).group_by{ |r| r.published_at.beginning_of_month }
	end

	def get_articles_by_month
		return @archives = Article.where(status: 'Published').where(visibility: 'Public').order(published_at: :desc).group_by{ |r| r.created_at.beginning_of_month }
	end

	def get_articles_by_category
		return @categories = Article.where(status: 'Published').where(visibility: 'Public').order(published_at: :desc).group_by{ |r| r.category.name}
	end

	def get_articles_by_author
		@user = User.find(params[:name])
		return @archives = Article.where(user_id: @user.id).where(status: 'Published').where(visibility: 'Public').order(published_at: :desc).group_by{ |r| r.category.name}
	end


	def get_scheduled_articles
		Article.where(status: 'Scheduled').where('published_at == ?', Date.today)
	end

	def publish_scheduled_articles
		@articles = get_scheduled_articles
		@articles.each do |article|
			article.publish_now
			article.user.tweet(@article.title + ' via ' + root_url + Shortener::ShortenedUrl.generate(article_url(@article)).unique_key)
		end
	end
end


