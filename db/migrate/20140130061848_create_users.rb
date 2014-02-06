class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :email, :limit => 256, :null => false
      t.string :imdb, :limit => 256
      t.string :website, :limit => 256

      t.timestamps
    end
    
    add_index :users, :email, :unique => true
  end
end
