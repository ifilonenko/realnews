class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :fname
      t.string :lname
      t.string :full_name
      t.string :email
      t.string :password_digest
      t.integer :num_endorsements
      t.integer :num_posts
      t.timestamps null: false
    end
  end
end
