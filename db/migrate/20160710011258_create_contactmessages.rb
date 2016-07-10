class CreateContactmessages < ActiveRecord::Migration
  def change
    create_table :contactmessages do |t|
      t.string :name
      t.string :email
      t.text :message

      t.timestamps null: false
    end
    add_index :contactmessages, :email
  end
end
