class CreateEmployees < ActiveRecord::Migration
  def self.up
    create_table :employees do |t|
      t.string :full_name, :limit => 120
      t.datetime  :date_of_birth
      t.string :designation, :limit => 50
      t.string  :sss, :limit => 20
      t.string  :pag_ibig, :limit => 20
      t.string  :phil_health, :limit => 20
      t.string  :bank_account_number, :limit => 20
      t.timestamps
    end
  end

  def self.down
    drop_table :employees
  end
end
