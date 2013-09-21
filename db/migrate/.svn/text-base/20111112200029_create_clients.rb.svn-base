class CreateClients < ActiveRecord::Migration
  def self.up
    create_table :clients do |t|
      t.string  :name, :limit => 120
      t.string  :contact_person, :limit => 120
      t.string  :contact_details, :limit => 150
      t.timestamps
    end
  end

  def self.down
    drop_table :clients
  end
end
