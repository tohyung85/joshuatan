class CreateBlogposts < ActiveRecord::Migration
  def change
    create_table :blogposts do |t|

      t.string :title
      t.text :content

      t.timestamps null: false
    end
    add_index :blogposts, :id
  end
end
