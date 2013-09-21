class AddColumnCommentToItemDisbursement < ActiveRecord::Migration
  def self.up
    add_column :item_disbursements, :comment, :text
  end

  def self.down
    remove_column :item_disbursements, :user
  end
end
