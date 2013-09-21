class AddColumnReturnedQtyInItemReleases < ActiveRecord::Migration
  def self.up
    add_column :item_releases, :returned_qty, :integer, :default => 0
  end

  def self.down
    remove_column :item_releases, :returned_qty
  end
end
