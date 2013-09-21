class CreateManPowerAssignmentHistories < ActiveRecord::Migration
  def self.up
    create_table :man_power_assignment_histories do |t|
      t.integer :employee_id
      t.integer :project_id
      t.integer :user_id
      t.timestamps
    end
  end

  def self.down
    drop_table :man_power_assignment_histories
  end
end
