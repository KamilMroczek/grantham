class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.string :title, :limit => 50, :null => false
      t.string :logline, :limit => 300, :null => false
      t.date :start_date, :null => false
      t.boolean :approved, :default => false

      t.timestamps
    end
  end
end
