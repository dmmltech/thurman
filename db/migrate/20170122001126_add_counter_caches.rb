class AddCounterCaches < ActiveRecord::Migration
  def change
  	add_column :articles, :impressions_count, :integer, :default => 0
  	add_column :tags, :impressions_count, :integer, :default => 0
  	add_column :categories, :impressions_count, :integer, :default => 0
  	add_column :pages, :impressions_count, :integer, :default => 0
  end
end
