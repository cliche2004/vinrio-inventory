class AddTypeForUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :itype, :string, :limit => 30
  end

  def self.down
    remove_column :users, :itype
  end
end
