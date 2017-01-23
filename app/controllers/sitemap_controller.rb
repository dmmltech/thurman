class SitemapController < ApplicationController
  

  def index
  	@articles = Article.order("created_at DESC")
  	@pages = Page.order("created_at DESC")
  	@categories = Category.order("created_at DESC")
  	@tags = Tag.order("created_at DESC")

  	respond_to do |format|
      format.xml
    end
  end
end
