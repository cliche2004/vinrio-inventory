class Item < ActiveRecord::Base
  
  belongs_to :storage_location
  belongs_to :measurement
  belongs_to :unit
  belongs_to :brand
  
  has_many :accessories, :dependent => :destroy
  
  has_many :item_releases, :dependent => :destroy
  has_many :item_disbursements, :through => :item_releases
  
  has_many :purchase_order_details
  
  has_many :item_specifics, :dependent => :destroy
  has_many :item_supplier, :through => :suppliers
  
  TYPEOF = [ 'Tools', 'Consumable' ]
  
  ITEMTYPE =  'Tools'
  CONSUMEABLETYPE = 'Consumable'
  
  validates_uniqueness_of :name, :scope =>  :brand_id,  :message => 'with brand is already exist'
  
  validates_presence_of :name, 
                        :reorder_qty, :current_qty, :type

  validates_numericality_of :current_qty, :reorder_qty
  
  has_attached_file :photo, :styles => { :medium => "300x300>", :thumb => "100x100>" }
  
  class << self
    
    def reorder
      self.find(:all, :conditions => ["current_qty <= reorder_qty"])
    end
    
    def csv_header 
    	"Barcode,Picture,SerialNo,Tool/Equipment,Description,StockOnHand,Measurement,Brand,Remarks".split(',') 
    end

    def csv_new(row) 
    	# find existing customer from email or create new 
    	cust = find_or_initialize_by_email(row[2])
    	
    	cust.attributes = {
		    	:first_name => row[0], 
		    	:last_name => row[1], 
		    	:email => row[3], 
		    	:phone => row[4], 
		    	:mobile => row[5], 
		    	:address => row[6], 
		    	:fax => row[7], 
		    	:city => row[8]
		  } 
		  return cust
   end
    
  end
  
end
