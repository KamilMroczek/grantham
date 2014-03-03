class CreateUserSkills < ActiveRecord::Migration
  def change
    create_table :user_skills do |t|
      t.integer :user_id, :null => false
      t.integer :skill_id, :null => false

      t.timestamps
    end
    
    add_index :user_skills, :user_id
    add_index :user_skills, :skill_id
  end
end
