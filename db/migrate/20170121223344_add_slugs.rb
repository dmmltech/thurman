class AddSlugs < ActiveRecord::Migration
  def change
  	add_column :articles, :slug, :string
  	add_column :tags, :slug, :string
  	add_column :categories, :slug, :string
  end
end
