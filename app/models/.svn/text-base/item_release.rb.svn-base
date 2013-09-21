class ItemRelease < ActiveRecord::Base
	
	has_one :user
	belongs_to :item
	belongs_to :item_disbursement
	
  validates_presence_of :item_disbursement_id
  
  after_create :update_item_current_qty
  after_update :update_item_current_qty
  
  def update_item_current_qty
    self.item.update_attribute('current_qty', item.current_qty - self.last_borrowed_qty)
  end
    
end
