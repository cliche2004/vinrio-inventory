class CreateManPowerAssignments < ActiveRecord::Migration
  def self.up
    create_table :man_power_assignments do |t|
      t.integer :user_id
      t.integer :project_id
      t.timestamps
    end
  end

  def self.down
    drop_table :man_power_assignments
  end
end
