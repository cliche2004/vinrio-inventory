class AddColumnStatusToProjects < ActiveRecord::Migration
  def self.up
    add_column :projects, :status, :string, :limit => 30, :default => 'OPEN'
    
    Project.update_all("status = 'OPEN'")
  
  end

  def self.down
    remove_column :projects, :status
  end
end
