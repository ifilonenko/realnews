class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.integer :like_count
      t.integer :user_id
      t.timestamps null: false
    end
  end
end
