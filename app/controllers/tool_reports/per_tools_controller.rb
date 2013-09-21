class ToolReports::PerToolsController < ApplicationController
	
   def index
  	_init
    render :partial => 'index'
  end
  
  def export_list
    _init
    csv_string = FasterCSV.generate do |csv| 
    	

    for item in @items do  
			csv << [item.name] 
			csv << ["Project/Location","Borrowers Name","Date Borrowered","Released By","Remarks","Expiration"]
			
			@disbursements = item.item_disbursements
			
			for disbursement in @disbursements do
		        csv << [disbursement.project && disbursement.project.project_unique_id, disbursement.user && disbursement.user.name, disbursement.project && disbursement.project.start_date.strftime('%Y/%m/%d'), disbursement.employee && disbursement.employee.full_name, '',disbursement.project && disbursement.project.estimated_end_date.strftime('%Y/%m/%d')]
		    end 
      end
    end
    
    send_data csv_string, :type => "text/csv", 
     :filename=>"PerTools_#{Time.now.to_s(:db)}.csv", 
     :disposition => 'attachment'
  end
  
  def _init
  	@items = Item.find(:all, :conditions => ['type_of = ? ', Item::ITEMTYPE])
  end
  
end
