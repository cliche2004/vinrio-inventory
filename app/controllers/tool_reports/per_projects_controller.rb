require 'fastercsv'

class ToolReports::PerProjectsController < ApplicationController
	
	def index
		@projects = Project.find(:all)
		render :partial => 'index'
	end

  def ajax_details
		render :update do |page|
			page.call "window.open", "/tool_reports/per_projects/ajax_info_list/#{params[:id]}","Per Person Details - Item Master", "location=0,status=0,scrollbars=yes,width=1000,height=500"
		end	
  end

  def ajax_info_list
    @borrowed_items = []
    @disbursement = ItemDisbursement.find(params[:id])
    @borrowed_items = @disbursement.item_releases.find(:all, :order => ['updated_at DESC'] ) if @disbursement
	
		render :partial => "details"
  end

  def ajax_item_search
  	item = params[:item]
  	session[:report_items] = params[:item]
  	
  	search = item[:project_id] ? item[:project_id] : ''

    @disbursements = ItemDisbursement.find(:all, :conditions => ['project_id = ? ', "#{search}"])

  	
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

  	@projects = Project.find(:all, :conditions => ['project_unique_id 	 LIKE ? ', "%#{search}%"])
		
		csv_string = FasterCSV.generate do |csv| 
			

		for project in @projects do   
			csv << [project.project_unique_id] 
			csv << ["Borrowers Name","Date Borrowered","Released By","Expiration","Accepted By","Remarks"]
			
			@disbursements = project.item_disbursements
			
			for disbursement in @disbursements do
				csv << [disbursement.employee  && disbursement.employee.full_name, disbursement.project && disbursement.project.start_date.strftime('%Y/%m/%d'),disbursement.user &&  disbursement.user.name,disbursement.project && disbursement.project.estimated_end_date.strftime('%Y/%m/%d'),disbursement.user  && disbursement.user.name,""]
			end
		end
	end

	send_data csv_string, :type => "text/csv", 
		:filename=>"project_#{Time.now.to_s(:db)}.csv", 
		:disposition => 'attachment'
	end

end
