class AddColumnStatusInManPowerAssignments < ActiveRecord::Migration
  def self.up
    add_column :man_power_assignments, :status, :boolean, :default => 1
  end

  def self.down
    remove_column :man_power_assignments, :status
  end
end
