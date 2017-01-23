class GiveUserOwnership < ActiveRecord::Migration
  def change
  	add_column :articles, :user_id, :integer
  	add_column :comments, :user_id, :integer

  	add_index :articles, :user_id
  	add_index :comments, :user_id

  	remove_column :users, :avatar, :string
  	remove_column :comments, :author_name, :string
  end
end
