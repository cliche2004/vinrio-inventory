class CreatePurchaseOrderDetails < ActiveRecord::Migration
  def self.up
    create_table :purchase_order_details do |t|
      t.integer :item_id
      t.integer :qty
      t.integer :purchase_order_id
      t.integer :unit_price
      t.integer :supplier_id
      t.timestamps
    end
  end

  def self.down
    drop_table :purchase_order_details
  end
end
