class Reports::PerPersonsController < ApplicationController
	
   def index
   	session[:report_items] = {}
   	
  	@employees = Employee.find(:all)
    render :partial => 'index'
  end

  def ajax_details
		render :update do |page|
			page.call "window.open", "/reports/per_persons/ajax_info_list/#{params[:id]}","Project Details - Item Master", "location=0,status=0,scrollbars=yes,width=900,height=500"
		end	
  end

  def ajax_info_list
		@records = ItemDisbursement.find(params[:id]).item_releases
		
		render :partial => "details"
  end

  def ajax_item_search
  	item = params[:item]
  	session[:report_items] = params[:item]
  	
  	search = item[:search] ? item[:search] : ''

  	@employees = Employee.find(:all, :conditions => ['full_name LIKE ? ', "%#{search}%"])
  	
  	render :update do |page|
			page.replace_html 'list', :partial => 'list' 
	  end
  end
  
  def export_list

  	item = session[:report_items].empty? ? [] : session[:report_items]
  	
  	search = item[:search] ? item[:search] : ''

  	@employees = Employee.find(:all, :conditions => ['full_name LIKE ? ', "%#{search}%"])
  	
    csv_string = FasterCSV.generate do |csv| 
    	
     for employee in @employees do   
			csv << [employee.full_name] 
			csv << ["Date Borrowered","Released By","Project/location","Date Returned","Accepted By","Remarks"]
			
			@disbursements = employee.item_disbursements
			
			for disbursement in @disbursements do
		        csv << [disbursement.created_at.strftime('%Y/%m/%d'), disbursement.user && disbursement.user.name, disbursement.project &&  disbursement.project.project_unique_id,disbursement.item_returns.first.returned_at.strftime('%Y/%m/%d'), disbursement.user && disbursement.user.name, disbursement.employee && disbursement.employee.full_name, disbursement.status]
		    end 
      end
    end
    
    send_data csv_string, :type => "text/csv", 
     :filename=>"person_#{Time.now.to_s(:db)}.csv", 
     :disposition => 'attachment'
  end
  
end
