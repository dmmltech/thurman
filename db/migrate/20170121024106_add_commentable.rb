class AddCommentable < ActiveRecord::Migration
  def change
  	add_column :comments, :media, :string
  	add_column :comments, :commentable_id, :integer, index: true, foreign_key: true
  	add_column :comments, :commentable_type, :string
  	remove_column :comments, :article_id
  end
end
