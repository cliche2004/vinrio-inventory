class CreatePurchaseOrders < ActiveRecord::Migration
  def self.up
    create_table :purchase_orders do |t|
      t.text :or
      t.integer :user_id
      t.timestamps
    end
  end

  def self.down
    drop_table :purchase_orders
  end
end
