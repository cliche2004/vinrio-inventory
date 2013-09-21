class AddUserIdInProjects < ActiveRecord::Migration
  def self.up
    add_column :projects, :client_id, :integer
    add_column :projects, :project_unique_id, :string
    add_column :projects, :assigned_employee_id, :integer
    remove_column :projects, :name
  end

  def self.down
    add_column :projects, :name, :string, :limit => 120
    remove_column :projects, :project_unique_id
    remove_column :projects, :assigned_employee_id
    remove_column :projects, :client_id
  end
end
