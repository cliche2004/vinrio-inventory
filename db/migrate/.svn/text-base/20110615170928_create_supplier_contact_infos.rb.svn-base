class CreateSupplierContactInfos < ActiveRecord::Migration
  def self.up
    create_table :supplier_contact_infos do |t|
      t.integer :supplier_id
      t.integer :contact_type_id
      t.text :data
      t.timestamps
    end
  end

  def self.down
    drop_table :supplier_contact_infos
  end
end
