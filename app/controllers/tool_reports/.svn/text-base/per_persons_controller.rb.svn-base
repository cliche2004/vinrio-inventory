class ToolReports::PerPersonsController < ApplicationController
	
   def index
   	session[:report_items] = {}
   	
  	@employees = Employee.find(:all)
    render :partial => 'index'
  end

  def ajax_details
		render :update do |page|
			page.call "window.open", "/tool_reports/per_persons/ajax_info_list/#{params[:id]}","Per Person Details - Item Master", "location=0,status=0,scrollbars=yes,width=1000,height=500"
		end	
  end

  def ajax_info_list
		#releases = ItemRelease.find(:all, :conditions => { :item_disbursement_id => params[:id]})                               
		#@items = Item.find(:all, :conditions => ["id IN(?) AND type_of LIKE ?", releases.collect(&:item_id), Item::ITEMTYPE])

    @borrowed_items = []
    @disbursement = ItemDisbursement.find(params[:id])
    @borrowed_items = @disbursement.item_releases.find(:all, :order => ['updated_at DESC'] ) if @disbursement
	
		render :partial => "details"
  end

  def ajax_item_search
  	item = params[:item]
  	session[:report_items] = params[:item]
  	
  	search = item[:employee_id] ? item[:employee_id] : ''

    @disbursements = ItemDisbursement.find(:all, :conditions => ['employee_id = ? ', "#{search}"])

  	render :update do |page|
  		if search	
				page.replace_html 'list', :partial => 'list'
			else
				page.replace_html 'list', :partial => 'list_all'
			end
	  end
  end
  
  def export_list

  	item = session[:report_items].empty? ? [] : session[:report_items]
  	
  	search = item[:search] ? item[:search] : ''

    if search	
    	@disbursements = ItemDisbursement.find(:all, :conditions => ['employee_id = ? ', "#{search}"])
  	else
  		@employees = Employee.find(:all)
	  end
  	
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
