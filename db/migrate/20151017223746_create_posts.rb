class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.text :description
      t.boolean :is_deleted
      t.string :image_url
      t.string :player_type
      t.string :player_embed
      t.integer :like_count
      t.integer :user_id
      t.timestamps null: false
    end
  end
end
