class RenameColumnUserIdToEmployeeIdInProblems < ActiveRecord::Migration
  def self.up
    rename_column :problems, :user_id, :employee_id
  end

  def self.down
    rename_column :problems, :employee_id, :user_id
  end
end
