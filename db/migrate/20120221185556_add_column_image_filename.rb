class AddColumnImageFilename < ActiveRecord::Migration
  def self.up
    add_column :items, :image_filename, :string
  end

  def self.down
    remove_column :items, :image_filename
  end
end
