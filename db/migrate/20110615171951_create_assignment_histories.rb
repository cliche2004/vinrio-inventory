class CreateAssignmentHistories < ActiveRecord::Migration
  def self.up
    create_table :assignment_histories do |t|
      t.integer :item_id
      t.integer :project_id
      t.integer :item_price
      t.integer :qty
      t.integer :user_making_qoute_id
      t.timestamps
    end
  end

  def self.down
    drop_table :assignment_histories
  end
end
