class Employee < ActiveRecord::Base

  has_many :item_disbursements
  
  Designation = [ 'Contractor', 'Sub-Contractor', 'Engineer' ]
  
  
  validates_presence_of :full_name, :date_of_birth, :designation
  
  
  class << self
    
    def none_engineer(limit = 5)
      self.find(:all, :conditions => ["designation != 'Engineer'"], :limit => limit )
    end
    
    def search_none_engineer(search)
      self.find(:all, :conditions => [ "full_name LIKE :value AND designation != 'Engineer'", 
                      { :value => "#{search}%" }])
    end
    
    def borrowers(limit = 5)
      self.find(:all, :limit => limit)
    end
    
    def search_borrower(search)
      self.find(:all, :conditions => ["full_name LIKE :value", { :value => "%#{search}%" }])
    end
    
    
    
  end
  
  
end
