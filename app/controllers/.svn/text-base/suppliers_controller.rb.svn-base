class SuppliersController < ApplicationController
  def index
  	_init
  	@suppliers = Supplier.find(:all, :order => ["created_at DESC"])
    render :partial => 'index'
  end
 
  def ajax_list
   	@supplier = Supplier.find(params[:id])
  	_init
  	render :update do |page|
		if @supplier
			page.replace_html 'list', :partial => 'list' 
	    end
	end
  end
    
  def ajax_new
  	@supplier = Supplier.new
  	
  	render :update do |page|
		page.replace_html 'list', :partial => 'new' 
	end
  end


  def ajax_edit
  	@supplier = Supplier.find(params[:id])
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
  	@supplier = Supplier.new(params[:supplier])
  	  	
	render :update do |page|
		if @supplier.save
			@suppliers = Supplier.find(:all)
			page.replace_html 'list', :partial => 'list' 			
		else
			page.replace_html 'message_area', error_messages_for(:supplier)
			page << "jQuery('#message_area').slideDown()"
		end
	end
   end 
   
  def ajax_update
  	begin
  	    @supplier = Supplier.find(params[:id])
  	
		render :update do |page|
			if @supplier.update_attributes(params[:supplier])
				@suppliers = Supplier.find(:all)
				page.replace_html 'list', :partial => 'list'
			else
	            page.replace_html 'message_area', error_messages_for(:supplier)
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
  	@supplier = Supplier.find(params[:id])
    
    render :update do |page|
	  	if @supplier.destroy
	  		@suppliers = Supplier.find(:all)
	  		page.replace_html 'list', :partial => 'list'
	  	end
	end
  end
  
  def _init
  	@suppliers = Supplier.find(:all)
  end
end
