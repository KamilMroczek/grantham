class AddCoverImageToProjects < ActiveRecord::Migration
  def self.up
     add_attachment :projects, :cover_image
   end

   def self.down
     remove_attachment :projects, :cover_image
   end
end
