class StorageLocationsController < ApplicationController
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
  	@storage_location = StorageLocation.new
  	
  	render :update do |page|
		page.replace_html 'list', :partial => 'new' 
	end
  end
  
  def ajax_edit
   	@storage_location = StorageLocation.find(params[:id])

  	render :update do |page|	
			page.replace_html 'list', :partial => 'edit' 
	end
  end 
  
  def ajax_create
  	@storage_location = StorageLocation.new(params[:storage_location])
  	  	
	render :update do |page|
		if @storage_location.save
			@storage_locations = StorageLocation.find(:all)
			page.replace_html 'list', :partial => 'list' 			
		else
			page.replace_html 'message_area', error_messages_for(:storage_location)
			page << "jQuery('#message_area').slideDown()"
		end
	end
   end 
   
  def ajax_update
  	begin
  	    @storage_location = StorageLocation.find(params[:id])
  	
		render :update do |page|
			if @storage_location.update_attributes(params[:storage_location])
				@storage_locations = StorageLocation.find(:all)
				page.replace_html 'list', :partial => 'list'
			else
	            page.replace_html 'message_area', error_messages_for(:storage_location)
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
  	@storage_location = StorageLocation.find(params[:id])
    
    render :update do |page|
	  	if @storage_location.destroy
	  		@storage_locations = StorageLocation.find(:all)
	  		page.replace_html 'list', :partial => 'list'
	  	end
	end
  end
  
  def _init
  	@storage_locations = StorageLocation.find(:all)
  end
end
