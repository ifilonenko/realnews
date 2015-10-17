class CreateEndorses < ActiveRecord::Migration
  def change
    create_table :endorses do |t|
      t.integer :endorser_id
    t.integer :endorsed_id
      t.timestamps null: false
    end
  end
end
