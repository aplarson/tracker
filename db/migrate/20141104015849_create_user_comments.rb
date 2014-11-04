class CreateUserComments < ActiveRecord::Migration
  def change
    create_table :user_comments do |t|
      t.integer :subject_id, null: false
      t.integer :author_id, null: false
      t.text :body, null: false

      t.timestamps
    end
    
    add_index :user_comments, :subject_id
    add_index :user_comments, :author_id
  end
end
