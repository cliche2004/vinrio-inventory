class RenameColumnUserIdToEmployeeId < ActiveRecord::Migration
  def self.up
    rename_column :item_disbursements, :assign_user_id, :employee_id
  end

  def self.down
    rename_column :item_disbursements, :employee_id, :assign_user_id
  end
end
