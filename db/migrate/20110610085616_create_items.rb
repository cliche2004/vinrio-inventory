class CreateItems < ActiveRecord::Migration
  def self.up
    create_table :items do |t|
      t.string :name
      t.integer :measurement_id
      t.integer :type_id
      t.integer :reoreder_qty
      t.integer :current_qty
      t.integer :item_asset_id
      t.string :serial_number
      t.text :comments
      t.timestamps
    end
  end

  def self.down
    drop_table :items
  end
end
