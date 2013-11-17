class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.string :title, :null => false
      t.string :logline, :limit => 140, :null => false
      t.text :description
      t.date :start_date

      t.timestamps
    end
  end
end
