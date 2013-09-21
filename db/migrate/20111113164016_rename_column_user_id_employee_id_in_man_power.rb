class RenameColumnUserIdEmployeeIdInManPower < ActiveRecord::Migration
  def self.up
    rename_column :man_power_assignments, :user_id, :employee_id
  end

  def self.down
    rename_column :man_power_assignments, :employee_id, :user_id
  end
end
