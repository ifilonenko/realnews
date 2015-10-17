class CreateSessions < ActiveRecord::Migration
  def change
    create_table :sessions do |t|
      t.integer :user_id
      t.string :session_code
      t.string :ip_address
      t.boolean :is_active
      t.timestamps null: false
    end
  end
end
