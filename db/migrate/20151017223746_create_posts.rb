class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.text :description
      t.text :short_description,  :limit => 200
      t.boolean :is_deleted
      t.string :player_type
      t.string :player_embed
      t.string :tagphoto_url
      t.integer :like_count
      t.integer :user_id
      t.timestamps null: false
    end
  end
end
