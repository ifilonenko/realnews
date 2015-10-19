class CreateImages < ActiveRecord::Migration
  def change
    create_table :images do |t|
      t.integer :imageable_id
      t.string :imageable_type
      t.string :file_file_name
      t.string :file_content_type
      t.integer :file_file_size
      t.datetime :file_updated_at

      t.timestamps null: false
    end
    add_index :images, :imageable_id
    add_index :images, :imageable_type
  end
end