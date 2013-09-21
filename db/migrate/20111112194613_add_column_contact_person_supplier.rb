class AddColumnContactPersonSupplier < ActiveRecord::Migration
  def self.up
    add_column :suppliers, :contact_person, :string
    add_column :suppliers, :contact_details, :string
  end

  def self.down
    remove_column :suppliers, :contact_details
    remove_column :suppliers, :contact_person
  end
end
