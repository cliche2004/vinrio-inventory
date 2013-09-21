class CreateSupplierContacts < ActiveRecord::Migration
  def self.up
    create_table :supplier_contacts do |t|
	  t.string :name
	  t.integer  :contact_type_id
	  t.integer  :supplier_id
      t.timestamps
    end
  end

  def self.down
    drop_table :supplier_contacts
  end
end
