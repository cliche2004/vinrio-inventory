class CreateSupplierContactNames < ActiveRecord::Migration
  def self.up
    create_table :supplier_contact_names do |t|
      t.string :name
      t.integer :supplier_id
      t.timestamps
    end
  end

  def self.down
    drop_table :supplier_contact_names
  end
end
