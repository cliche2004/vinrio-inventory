class AddColumnNameToSuppliers < ActiveRecord::Migration
  def self.up
  	add_column :suppliers, :name, :string, :limit => 100
  end

  def self.down
  	remove_column :suppliers, :name
  end
end
