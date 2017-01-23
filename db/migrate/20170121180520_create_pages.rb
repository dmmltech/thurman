class CreatePages < ActiveRecord::Migration
  def change
    create_table :pages do |t|
      t.string :title
      t.text :body
      t.date :published_at
      t.string :slug
      t.string :status
      t.integer :order
      t.integer :parent_id
      t.timestamps null: false
    end
    add_foreign_key :pages, :pages, column: :parent_id, primary_key: :id
    add_index :pages, :parent_id
  end
end
