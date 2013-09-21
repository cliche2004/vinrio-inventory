class ItemTypesController < ApplicationController
  def index
  	_init
    render :partial => 'index'
  end
	
  def ajax_new
  	@type = ItemType.new
  	
  	render :update do |page|
		page.replace_html 'list', :partial => 'new' 
	end
  end
  	
  def ajax_edit
   	@type = ItemType.find(params[:id])

  	render :update do |page|
		if @type
			page.replace_html 'list', :partial => 'edit' 
	    end
	end
  end 
  
  def ajax_list
  	_init
  	render :update do |page|
		page.replace_html 'list', :partial => 'list' 
	   
	end
  end

  
  def ajax_create
  	@type = ItemType.new(params[:type])
  	  	
	render :update do |page|
		if @type.save
			@types = ItemType.find(:all)
			page.replace_html 'list', :partial => 'list' 			
		else
			page.replace_html 'message_area', error_messages_for(:type)
			page << "jQuery('#message_area').slideDown()"
		end
	end
   end 
   
  def ajax_update
  	begin
	  	@type = ItemType.find(params[:id])
	  	
		render :update do |page|
			if @type.update_attributes(params[:type])
				@types = ItemType.find(:all)
				page.replace_html 'list', :partial => 'list'
			else
	            page.replace_html 'message_area', error_messages_for(:type)
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
  	@type = ItemType.find(params[:id])
    
    render :update do |page|
	  	if @type.destroy
	  		@types = ItemType.find(:all)
	  		page.replace_html 'list', :partial => 'list'
	  	end
	end
  end
  
  def _init
  	@types = ItemType.find(:all)
  end
end
