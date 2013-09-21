class AddStorageLocationIdOnItems < ActiveRecord::Migration
  def self.up
     add_column :items, :storage_location_id, :integer
  end

  def self.down
  	 remove_column :items, :storage_location_id
  end
end
