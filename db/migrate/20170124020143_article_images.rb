class ArticleImages < ActiveRecord::Migration
  def change
  	add_column :articles, :image, :string
  	add_column :pages, :image, :string
  end
end
