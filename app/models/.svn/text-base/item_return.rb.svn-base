class ItemReturn < ActiveRecord::Base
	
	belongs_to :item
	belongs_to :item_disbursement
	belongs_to :recieved_by, :class_name => "User", :foreign_key => :recieved_by_id
	
	
	validates_presence_of :item_id,:qty, 
	                      :item_disbursement_id, :returned_at
	
	after_create :update_item_current_qty
	
	
	def update_item_current_qty
	  self.item.update_attribute('current_qty', item.current_qty.to_i + self.qty.to_i)
	end
	
	class << self
	  
	
	end
	
end
