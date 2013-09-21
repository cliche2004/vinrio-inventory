class PersonnelReturnsController < ApplicationController
	
  def index
  	@employees = ItemDisbursement.find(:all, 
  	                      :group => [ "employee_id" ],
  	                      :include => [:project, :user, :employee], 
  	                      :order => ["created_at DESC"])
    render :partial => 'index'
  end
  
  def ajax_list
  	search = params[:personnel_return][:name] if params[:personnel_return]
  	@projects = ItemDisbursement.find(:all, :include => [:project, :user, :employee], :order => ["created_at DESC"])
  	
  	render_update_page('list', 'list', {})
  
  end
  
   def add
    @assign_items = params[:items]
    @disbursement = ItemDisbursement.new(params[:header])
    
    ItemDisbursement.transaction do
      if @disbursement.save
        # save items
        for assign_item in @assign_items
          
          item_id = assign_item[:item_id]
          qty = assign_item[:qty]
          is_returnable = assign_item[:is_returnable]
          
          item_release = ItemRelease.create :item_disbursement_id => @disbursement.id,
                                            :item_id => item_id,
                                            :qty => qty,
                                            :is_returnable => is_returnable,
                                            :released_at => Time.now
                                          
          #item.update_attribute('current_qty', item.current_qty - qty.to_i)
        
        end
      
      else
      end
    end
    
   end 
  
	
  def listing
  	  	
  	@employee = Employee.find(params[:id])
  	  	  	
  	@projects = ItemDisbursement.find(:all, :conditions => { :employee_id => @employee.id }, :include => [:project])
	   	
  	render :update do |page|
		  page.replace_html 'list', :partial => 'assigned'
	  end
  end	

  
  def ajax_edit
   	@item_return = ItemReturn.find(params[:id])
  	
  	render :update do |page|
		  if @item_return
			  page.replace_html 'list', :partial => 'assigned' 
	    end
	  end
  end 


  def ajax_update
  	@item_return = ItemReturn.find(params[:id])
  	
	  render :update do |page|
		  if @item_return.update_attributes(params[:item_return])
			  @item_returns = ItemReturn.find(:all)
			  page.replace_html 'list', :partial => 'list'
		  else
          page.replace_html 'message_area', error_messages_for(:item_return)
          page << "jQuery('#message_area').slideDown()"
        end
	    end
  end
  
  def ajax_delete
  	@item_return = ItemReturn.find(params[:id])
    
    render :update do |page|
	  	if @item_return.destroy
	  		@item_returns = ItemReturn.find(:all)
	  		page.replace_html 'list', :partial => 'list'
	  	end
	  end
  end
  
  def ajax_item_list
  	search = params[:item][:name] if params[:item]
  	@items = Item.find(:all, :conditions => ['name LIKE ?', "%#{search}%"])
  	render :update do |page|
			page.replace_html 'item_list_table', :partial => 'item_list_table' 
	  end
  end
  
  def search_project
    @search = params[:search]
    
    @projects = ItemDisbursement.find(:all, :include => [:project, :user, :assign_user],
                    :conditions => ["projects.name LIKE :value", { :value => "#{@search}%" }],
                    :order => ["item_disbursements.created_at DESC"]
                    )
    
    render_update_page('project_list_table', 'item_list_table')
    
    
  end
  
  def update_borrowed_item
 #   begin
      rqty = params[:rqty].to_i
      assigned_item_id = params[:assigned_item_id]
    
      item = ItemRelease.find(assigned_item_id)
       
      render :update do |page|
        ItemReturn.transaction do 
          
          if item.qty >= rqty && rqty > 0
          
            ItemReturn.create :item_id => item.item.id, 
                              :item_disbursement_id => item.item_disbursement.id,
                              :qty => rqty,
                              :returned_at => Time.now,
                              :recieved_by => current_user.id
          
            item.update_attribute('returned_qty', item.returned_qty + rqty) # update item qty
          
            page.replace_html "returned_qty_#{item.id}", item.returned_qty
            page << "$('#item_qty_#{item.id}').val('0')"
        
            page.replace_html 'message_area', "Item was Successfully Updated"
      			page << "jQuery('#message_area').slideDown()"

          else  
        
            page.replace_html 'message_area', "Please Check Qty Inputted"
      			page << "jQuery('#message_area').slideDown()"
        
           end
           
        end
        
      end
      
  end
  

  def _init
  	@items = Item.all(:limit => 5)
  end
  	
end
