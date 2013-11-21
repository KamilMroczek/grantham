class DontAllowNullForStartDate < ActiveRecord::Migration
  def up
    change_column :projects, :start_date, :date, :null => false
  end
  
  def down
    change_column :projects, :start_date, :date
  end
end
