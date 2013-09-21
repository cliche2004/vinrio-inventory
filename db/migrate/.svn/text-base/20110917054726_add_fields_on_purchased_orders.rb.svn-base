class AddFieldsOnPurchasedOrders < ActiveRecord::Migration
  def self.up
  	add_column :purchase_orders, :project_id, :integer 
  	add_column :purchase_orders, :requested_by, :integer
  	add_column :purchase_orders, :approve_by, :integer
  	add_column :purchase_orders, :terms, :integer
  	add_column :purchase_orders, :delivery_date, :string
  end

  def self.down
  	remove_column :purchase_orders, :project_id
  	remove_column :purchase_orders, :requested_by 
  	remove_column :purchase_orders, :approve_by 
  	remove_column :purchase_orders, :terms
  	remove_column :purchase_orders, :delivery_date 
  end
end
