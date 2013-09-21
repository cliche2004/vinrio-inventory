class RenameColumnTypeInItems < ActiveRecord::Migration
  def self.up
    
    add_column :items, :type_of, :string
  
    items = Item.all
    
    items.each do |item|
      item.update_attribute(:type_of, item.type.name)
    end
  
    remove_column :items, :type_id
  end

  def self.down
    
    add_column :items, :type_id, :integer
    remove_column :items, :type_of
    
  end
end
