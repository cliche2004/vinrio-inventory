class CreateAccessories < ActiveRecord::Migration
  def self.up
    create_table :accessories do |t|
      t.integer :item_id
      t.string :name
      t.timestamps
    end
  end

  def self.down
    drop_table :accessories
  end
end
