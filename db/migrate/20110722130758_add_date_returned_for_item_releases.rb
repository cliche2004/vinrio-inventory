class AddDateReturnedForItemReleases < ActiveRecord::Migration
  def self.up
    add_column :item_releases, :date_returned, :datetime
  end

  def self.down
    remove_column :item_releases, :date_returned
  end
end
