class EmployeesController < ApplicationController
  def index
  	_init
    render :partial => 'index'
  end
 
  def ajax_list   	
  	_init
  	render :update do |page|
		page.replace_html 'list', :partial => 'list' 
	end
  end
  
  def ajax_new
  	@employee = Employee.new
  	
  	render :update do |page|
		page.replace_html 'list', :partial => 'new' 
	end
  end
  
  
  def ajax_edit
   	@employees = Employee.find(params[:id])
  	render :update do |page|
		page.replace_html 'list', :partial => 'edit' 
	end
  end 
  
  def ajax_create
  	@employee = Employee.new(params[:employee])
  	  	
	render :update do |page|
		if @employee.save
			@employees = Employee.find(:all)
			page.replace_html 'list', :partial => 'list' 			
		else
			page.replace_html 'message_area', error_messages_for(:employee)
			 page << "jQuery('#message_area').slideDown()"
		end
	end
   end 
   
  def ajax_update
  	begin
  	    @employee = Employee.find(params[:id])
  	
		render :update do |page|
			if @employee.update_attributes(params[:brand])
				@employees = Employee.find(:all)
				page.replace_html 'list', :partial => 'list'
			else
	            page.replace_html 'message_area', error_messages_for(:employee)
	            page << "jQuery('#message_area').slideDown()"
	       end
		end
    rescue ActiveRecord::RecordNotFound => e
    	render :update do |page|
           page.replace_html 'message_area', "Record not found: #{params[:id]}"
        end
    end
  end
  
  def ajax_delete
  	@employee = Employee.find(params[:id])
    
    render :update do |page|
	  	if @employee.destroy
	  		@employees = Employee.find(:all)
	  		page.replace_html 'list', :partial => 'list'
	  	end
	end
  end
  
  def _init
  	@employees = Employee.all
  end
end
