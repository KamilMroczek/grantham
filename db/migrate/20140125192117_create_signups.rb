class CreateSignups < ActiveRecord::Migration
  def change
    create_table :signups do |t|
      t.string :email, :limit => 256, :null => false
      t.string :imdb, :limit => 256
      t.string :website, :limit => 256
      t.boolean :approved, :default => false

      t.timestamps
    end
    
    add_index :signups, :email, :unique => true
  end
end
