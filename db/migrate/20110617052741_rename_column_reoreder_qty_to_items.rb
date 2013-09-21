class RenameColumnReorederQtyToItems < ActiveRecord::Migration
  def self.up
  	rename_column :items, :reoreder_qty, :reorder_qty
  end

  def self.down
  	rename_column :items, :reorder_qty, :reoreder_qty
  end
end
