class CreateItemReleases < ActiveRecord::Migration
  def self.up
    create_table :item_releases do |t|
      t.integer   :item_disbursement_id
      t.integer   :item
      t.integer   :qty
      t.datetime  :released_at
      t.boolean   :is_returnable, :default => true
      t.boolean   :all_returned, :default => false
      t.timestamps
    end
  end

  def self.down
    drop_table :item_releases
  end
end
