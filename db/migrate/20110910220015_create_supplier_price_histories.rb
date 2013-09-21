class CreateSupplierPriceHistories < ActiveRecord::Migration
  def self.up
    create_table :supplier_price_histories do |t|
      t.integer :supplier_id
      t.integer :item_id
      t.integer :price
      t.timestamps
    end
  end

  def self.down
  	drop_table :supplier_price_histories
  end
end
