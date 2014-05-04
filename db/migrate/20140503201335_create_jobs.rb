class CreateJobs < ActiveRecord::Migration
  def change
    create_table :jobs do |t|
      t.integer :project_id, :null => false
      t.integer :skill_id, :null => false

      t.timestamps
    end
  end
end
