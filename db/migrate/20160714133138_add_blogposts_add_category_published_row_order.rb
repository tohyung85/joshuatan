class AddBlogpostsAddCategoryPublishedRowOrder < ActiveRecord::Migration
  def change
    add_column :blogposts, :row_order, :integer
    add_column :blogposts, :category, :string
    add_column :blogposts, :published, :boolean, :default => false
    add_index :blogposts, :row_order
  end
end
