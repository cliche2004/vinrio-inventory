class Project < ActiveRecord::Base

  belongs_to :item_release
  belongs_to :client
  belongs_to :assigned_user, :class_name => 'Employee', :foreign_key => :assigned_employee_id
  
	has_many :man_powers, :class_name => 'ManPowerAssignment'
	has_many :employees, :through => :man_powers
	has_many :problems
	has_many :item_disbursements
	
  validates_presence_of :project_unique_id, :start_date, :estimated_end_date, :client_id
  validates_uniqueness_of :project_unique_id

end
