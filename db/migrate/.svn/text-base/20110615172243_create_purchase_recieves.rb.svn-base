class CreatePurchaseRecieves < ActiveRecord::Migration
  def self.up
    create_table :purchase_recieves do |t|
      t.integer :purchase_order_id
      t.integer :supplier_id
      t.text :comment
      t.timestamps
    end
  end

  def self.down
    drop_table :purchase_recieves
  end
end
