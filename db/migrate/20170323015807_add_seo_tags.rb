class AddSeoTags < ActiveRecord::Migration
  def change
  	add_column :articles, :seotitle, :string
		add_column :articles, :seodescription, :text
		add_column :pages, :seotitle, :string
		add_column :pages, :seodescription, :text
		add_column :pages, :menuslug, :string
		add_column :categories, :icon, :string
		add_column :categories, :color, :string
		add_column :categories, :seodescription, :text
  end
end
