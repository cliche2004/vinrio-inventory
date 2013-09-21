class ClientsController < ApplicationController
  def index
  	_init
    render :partial => 'index'
  end
 
  def ajax_list
   	@client = Client.find(params[:id])
  	_init
  	render :update do |page|
		if @client
			page.replace_html 'list', :partial => 'list' 
	    end
	end
  end
    
  def ajax_new
  	@client = Client.new
  	
  	render :update do |page|
		page.replace_html 'list', :partial => 'new' 
	end
  end


  def ajax_edit
  	@client = Client.find(params[:id])
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
  	@client = Client.new(params[:client])
  	  	
	render :update do |page|
		if @client.save
			@clients = Client.find(:all)
			page.replace_html 'list', :partial => 'list' 			
		else
			page.replace_html 'message_area', error_messages_for(:client)
			page << "jQuery('#message_area').slideDown()"
		end
	end
   end 
   
  def ajax_update
  	begin
  	    @client = Client.find(params[:id])
  	
		render :update do |page|
			if @client.update_attributes(params[:client])
				@clients = Client.find(:all)
				page.replace_html 'list', :partial => 'list'
			else
        page.replace_html 'message_area', error_messages_for(:client)
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
  	@client = Client.find(params[:id])
    
    render :update do |page|
	  	if @client.destroy
	  		@clients = Client.find(:all)
	  		page.replace_html 'list', :partial => 'list'
	  	end
	end
  end
  
  def _init
  	@clients = Client.find(:all)
  end
end
