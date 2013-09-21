class MeasurementsController < ApplicationController
  def index
  	_init
    render :partial => 'index'
  end
    
  def ajax_new
  	@unit = Measurement.new
  	
  	render :update do |page|
		page.replace_html 'list', :partial => 'new' 
	end
  end
  
  def ajax_edit
   	@unit = Measurement.find(params[:id])
  	render :update do |page|
			page.replace_html 'list', :partial => 'edit' 
	
	end
  end 
    
  def ajax_list
  	_init
  	render :update do |page|
		page.replace_html 'list', :partial => 'list' 
	   
	end
  end

  
  def ajax_create
  	@unit = Measurement.new(params[:unit])
  	  	
	render :update do |page|
		if @unit.save
			@units = Measurement.find(:all)
			page.replace_html 'list', :partial => 'list' 			
		else
			page.replace_html 'message_area', error_messages_for(:unit)
			page << "jQuery('#message_area').slideDown()"
		end
	end
   end 
   
  def ajax_update
  	begin
	  	@unit = Measurement.find(params[:id])
	  	
		render :update do |page|
			if @unit.update_attributes(params[:unit])
				@units = Measurement.find(:all)
				page.replace_html 'list', :partial => 'list'
			else
	          page.replace_html 'message_area', error_messages_for(:unit)
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
  	@unit = Measurement.find(params[:id])
    
    render :update do |page|
	  	if @unit.destroy
	  		@units = Measurement.find(:all)
	  		page.replace_html 'list', :partial => 'list'
	  	end
	end
  end
  
  def _init
  	@units = Measurement.find(:all)
  end
end
