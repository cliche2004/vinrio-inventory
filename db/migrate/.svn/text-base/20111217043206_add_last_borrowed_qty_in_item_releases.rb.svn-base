class AddLastBorrowedQtyInItemReleases < ActiveRecord::Migration
  def self.up
    add_column :item_releases, :last_borrowed_qty, :integer
  end

  def self.down
    remove_column :item_releases, :last_borrowed_qty
  end
end
