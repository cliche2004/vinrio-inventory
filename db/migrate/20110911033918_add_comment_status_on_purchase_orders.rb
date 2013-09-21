class AddCommentStatusOnPurchaseOrders < ActiveRecord::Migration
  def self.up
  	add_column :purchase_orders, :status, :string, :default => 'Open'
  	add_column :purchase_orders, :comment, :text
  end

  def self.down
  	remove_column :purchase_orders, :status
  	remove_column :purchase_orders, :comment
  end
end
