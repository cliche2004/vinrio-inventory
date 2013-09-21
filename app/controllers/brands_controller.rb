class BrandsController < ApplicationController
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
  	@brand = Brand.new
  	
  	render :update do |page|
		page.replace_html 'list', :partial => 'new' 
	end
  end
  
  
  def ajax_edit
   	@brand = Brand.find(params[:id])
  	render :update do |page|
		page.replace_html 'list', :partial => 'edit' 
	end
  end 
  
  def ajax_create
  	@brand = Brand.new(params[:brand])
  	  	
	render :update do |page|
		if @brand.save
			@brands = Brand.find(:all)
			page.replace_html 'list', :partial => 'list' 			
		else
			page.replace_html 'message_area', error_messages_for(:brand)
			 page << "jQuery('#message_area').slideDown()"
		end
	end
   end 
   
  def ajax_update
  	begin
  	    @brand = Brand.find(params[:id])
  	
		render :update do |page|
			if @brand.update_attributes(params[:brand])
				@brands = Brand.find(:all)
				page.replace_html 'list', :partial => 'list'
			else
	            page.replace_html 'message_area', error_messages_for(:brand)
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
  	@brand = Brand.find(params[:id])
    
    render :update do |page|
	  	if @brand.destroy
	  		@brands = Brand.find(:all)
	  		page.replace_html 'list', :partial => 'list'
	  	end
	end
  end
  
  def _init
  	@brands = Brand.find(:all)
  end
end
