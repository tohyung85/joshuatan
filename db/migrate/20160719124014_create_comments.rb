class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|

      t.string :name
      t.text :message
      t.integer :blog_id

      t.timestamps null: false
    end
    add_index :comments, :blog_id
  end
end
