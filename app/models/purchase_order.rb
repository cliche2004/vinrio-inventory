class PurchaseOrder < ActiveRecord::Base
  
  has_many :details, :class_name => 'PurchaseOrderDetail'
  belongs_to :assign_user, :class_name => 'User', :foreign_key => :assign_user_id
  belongs_to :user
  belongs_to :supplier
  
	validates_presence_of :or, :supplier_id, :supplier_contact_id
	
	after_update :update_item_current_qty
	
	def update_item_current_qty
      
      for detail in self.details
      		item = Item.find(detail.item_id)
	        item.update_attribute('current_qty', item.current_qty + detail.qty)
      	
	  		SupplierPriceHistory.create  :item_id => detail.item_id,
	  							  		 :supplier_id => detail.supplier_id,
	  									 :price =>  detail.unit_price 
      end
      
	end
end
