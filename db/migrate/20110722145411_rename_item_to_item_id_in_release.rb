class RenameItemToItemIdInRelease < ActiveRecord::Migration
  def self.up
    rename_column :item_releases, :item, :item_id
  end

  def self.down
    rename_column :item_releases, :item_id, :item
  end
end
