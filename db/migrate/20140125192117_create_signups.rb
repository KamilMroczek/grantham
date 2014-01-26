class CreateSignups < ActiveRecord::Migration
  def change
    create_table :signups do |t|
      t.string :email, :null => false
      t.string :imdb, :limit => 128
      t.string :linkedin, :limit => 128
      t.string :photo, :limit => 256
      t.boolean :approved, :default => false
      t.boolean :complete, :default => false

      t.timestamps
    end
    
    add_index :signups, :email, :unique => true
  end
end
