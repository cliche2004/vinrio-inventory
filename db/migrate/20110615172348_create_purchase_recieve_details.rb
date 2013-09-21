class CreatePurchaseRecieveDetails < ActiveRecord::Migration
  def self.up
    create_table :purchase_recieve_details do |t|
      t.integer :purchase_recieve_id
      t.integer :item_id
      t.integer :qty_received
      t.integer :receive_by_user_id
      t.timestamps
    end
  end

  def self.down
    drop_table :purchase_recieve_details
  end
end
