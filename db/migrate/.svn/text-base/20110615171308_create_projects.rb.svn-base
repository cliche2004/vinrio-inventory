class CreateProjects < ActiveRecord::Migration
  def self.up
    create_table :projects do |t|
      t.string :name
      t.boolean :is_test, :default => false
      t.boolean :is_active, :default => true
      t.integer :profit_margin
      t.date :start_date
      t.date :estimated_end_date
      t.timestamps
    end
  end

  def self.down
    drop_table :projects
  end
end
