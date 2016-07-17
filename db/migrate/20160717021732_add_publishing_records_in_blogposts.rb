class AddPublishingRecordsInBlogposts < ActiveRecord::Migration
  def change
    add_column :blogposts, :publish_date, :date
    add_index :blogposts, :publish_date
  end
  
end
