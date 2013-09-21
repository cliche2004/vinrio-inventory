class AddColumnRecieveByIdItemReturns < ActiveRecord::Migration
  def self.up
    add_column :item_returns, :recieved_by_id, :integer
  end

  def self.down
    remove_column :item_returns, :recieved_by_id
  end
end
