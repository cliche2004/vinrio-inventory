class SupplierContactsController < ApplicationController
	
  def ajax_list
    _init
    render :update do |page|
  		page.replace_html 'list', :partial => 'supplier_contacts/list' 
	   
  	end
  end
  
  def get_contacts
  	@contacts = Supplier.find(params[:id]).supplier_contacts
  	render :update do |page|
			page.replace_html '.supplier_select', :text => collection_select(:header, :supplier_contact_id, @contacts, :id, :name, {} , :style => 'width: 300px' )
	end
  end
  
  def ajax_new
  	@contacts = Supplier.find(params[:id]).supplier_contacts
  	@types = ContactType.find(:all)
  	@supplier_id =  params[:id]
  	
  	render :update do |page|
		page.replace_html 'list', :partial => 'supplier_contacts/new' 
	end
  end


  def ajax_edit
  	@supplier_contact = SupplierContact.find(params[:id])
	@types = ContactType.find(:all)
	@supplier_id = @supplier_contact.supplier_id

    	render :update do |page|
  		page.replace_html 'list', :partial => 'supplier_contacts/edit' 
  	end
  end 
  
  def ajax_create
  	@supplier_contact = SupplierContact.new(params[:supplier_contact])
  	  	
	render :update do |page|
		if @supplier_contact.save
            @contacts = Supplier.find(params[:supplier_contact][:supplier_id]).supplier_contacts
			page.replace_html 'item_list_table', :partial => 'list' 			
		else
			page.replace_html 'message_area', error_messages_for(:supplier)
			page << "jQuery('#message_area').slideDown()"
		end
	end
   end 
 
  def ajax_update
  	begin
  	    @contact = SupplierContact.find(params[:supplier_contact][:id])
  	
		render :update do |page|
			if @contact.update_attributes(params[:supplier_contact])
				@contacts = SupplierContact.find(:all)
				@types = ContactType.find(:all)
				page.replace_html 'list', :partial => 'list'
			else
	            page.replace_html 'message_area', error_messages_for(:supplier_contact)
	            page << "jQuery('#message_area').slideDown()"
	       end
		end
    rescue ActiveRecord::RecordNotFound => e
    	render :update do |page|
           page.replace_html 'message_area', "Record not found: #{params[:id]}"
        end
    end
  end
end
