class PurchaseRecieve < ActiveRecord::Base
  
  has_many :details, :class_name => 'PurchaseReceiveDetail'
  
end
