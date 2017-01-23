class UpdateArticleFields < ActiveRecord::Migration
  def change
  	add_column :articles, :published_at, :date
  	add_column :articles, :status, :string
  	add_column :articles, :visibility, :string
  	add_column :pages, :visibility, :string
  end
end
