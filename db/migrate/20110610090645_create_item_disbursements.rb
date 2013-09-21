class CreateItemDisbursements < ActiveRecord::Migration
  def self.up
    create_table :item_disbursements do |t|
      t.integer :assign_user_id
      t.integer :user_id
      t.integer :project_id
      t.timestamps
    end
  end

  def self.down
    drop_table :item_disbursements
  end
end
