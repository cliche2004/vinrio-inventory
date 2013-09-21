class ItemDisbursement < ActiveRecord::Base
  belongs_to :user
  belongs_to :employee
  belongs_to :project
  
  has_many :item_releases
  has_many :item_returns, :order => "returned_at DESC"
  
  validates_presence_of :project_id, :employee_id
  
  
end
