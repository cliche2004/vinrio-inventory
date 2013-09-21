class ContactTypesController < ApplicationController
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
  	@contact_type =ContactType.new
  	
  	render :update do |page|
		page.replace_html 'list', :partial => 'new' 
	end
  end
  
  def ajax_edit
   	@contact_type = ContactType.find(params[:id])
  	render :update do |page|
			page.replace_html 'list', :partial => 'edit' 

	end
  end 
  
  def ajax_create
  	@contact_type = ContactType.new(params[:contact_type])
  	  	
	render :update do |page|
		if @contact_type.save
			@contact_types = ContactType.find(:all)
			page.replace_html 'list', :partial => 'list' 			
		else
			page.replace_html 'message_area', error_messages_for(:contact_type)
			page << "jQuery('#message_area').slideDown()"
		end
	end
   end 
   
  def ajax_update
  	begin
  	    @contact_type = ContactType.find(params[:id])
  	
		render :update do |page|
			if @contact_type.update_attributes(params[:contact_type])
				@contact_types = ContactType.find(:all)
				page.replace_html 'list', :partial => 'list'
			else
	            page.replace_html 'message_area', error_messages_for(:contact_type)
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
  	@contact_type = ContactType.find(params[:id])
    
    render :update do |page|
	  	if @contact_type.destroy
	  		@contact_types = ContactType.find(:all)
	  		page.replace_html 'list', :partial => 'list'
	  	end
	end
  end
  
  def _init
  	@contact_types = ContactType.find(:all)
  end
end
