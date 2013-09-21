class AddRemarksForItem < ActiveRecord::Migration
  def self.up
    add_column :items, :remarks, :string
  end

  def self.down
    remove_column :items, :remarks
  end
end
