class ItemReturnsController < ApplicationController
  
  def index
    @projects = ItemDisbursement.find(:all, :include => [:project, :user, :assign_user], :order => ["created_at DESC"])
    render :partial => 'index'
  end

  def ajax_list
  	search = params[:item_return][:name] if params[:item_return]
  	@projects = ItemDisbursement.find(:all, :include => [:project, :user, :assign_user], :order => ["created_at DESC"])
  	
  	render_update_page('list', 'list', {})
  
  end

  def ajax_new
  	@item_return = ItemReturn.new
  	render :update do |page|
		  page.replace_html 'list', :partial => 'new' 
	  end
  end
	
  def ajax_assigned
   	@item = ItemDisbursement.find(params[:id], :include => [:project])
   
   	@assigned_items = @item.item_releases
   	@items = Item.find(:all)
   	
  	render :update do |page|
		  if @item
			  page.replace_html 'list', :partial => 'assigned' 
	    end
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

  def ajax_create
  	@item_return = ItemReturn.new(params[:purchase_order])
  	  	
	  render :update do |page|
		  if @item_return.save
			  @item_returns = ItemReturn.find(:all)
			  page.replace_html 'list', :partial => 'list' 			
		  else
			  page.replace_html 'message_area', error_messages_for(:item_return)
			  page << "jQuery('#message_area').slideDown()"
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
    begin
      rqty = params[:rqty].to_i
      assigned_item_id = params[:assigned_item_id]
    
      item = ItemRelease.find(assigned_item_id) #qty, returned_qty
      
      should_return_qty = item.qty - item.returned_qty
      
      raise StandardError if rqty > should_return_qty || rqty <= 0
       
      render :update do |page|
                
        item.update_attribute('returned_qty', item.returned_qty + rqty) # update item qty
        
        ItemReturn.create :item_id => item.item.id, 
                          :item_disbursement_id => item.item_disbursement.id,
                          :qty => rqty,
                          :returned_at => Time.now,
                          :recieved_by_id => current_user.id 
        
        
        disbursement = item.item_disbursement
        
        
        page.replace_html "returned_qty_#{item.id}", item.returned_qty
        page << "$('#item_qty_#{item.id}').val('0')"                    
        page << "alert('Item was sucessfully updated!')"
        page << "$('#prr_#{item.item_disbursement.id}').html('#{ escape_javascript(render :partial => 'personnel_returns/item_return_list', :locals => { :returned_items => disbursement.item_returns }) }')"
    			        
    			        
#    		 <%= render :partial => "item_return_list", :locals => { :returned_items => project.item_returns } %>	        
    			        
      end

    rescue StandardError => e
         render :update do |page|
           page << "alert('Please check qty inputted! - qty should not be more than #{should_return_qty} or 0')"
         end
    end

  end
  

  def _init
  	@items = Item.all(:limit => 5)
  end

end
