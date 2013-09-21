class CreateItemReturns < ActiveRecord::Migration
  def self.up
    create_table :item_returns do |t|
      t.integer   :qty
      t.integer   :item_disbursement_id
      t.datetime  :returned_at
      t.timestamps
    end
  end

  def self.down
    drop_table :item_returns
  end
end
