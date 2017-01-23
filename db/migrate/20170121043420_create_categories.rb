class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.string :name
      t.integer :parent_id
      t.timestamps null: false
    end
    add_foreign_key :categories, :categories, column: :parent_id, primary_key: :id
    add_index :categories, :parent_id
  end
end