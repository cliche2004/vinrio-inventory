class ItemAssignmentsController < ApplicationController
 
  def index
    @header = ItemDisbursement.new
    session[:items] = {}

    _init
    
    render :partial => 'index'
  end
 
  def ajax_list
    @headers = ItemDisbursement.find(:all)
  	@item_assignments = ItemRelease.find(:all)

  	render :update do |page|
			page.replace_html 'hlist', :partial => 'list' 
	  end
  end
    
  def ajax_new
  	@item_assignment =ItemRelease.new
	  @header = ItemDisbursement.new
    _init
  	render :update do |page|
		  page.replace_html 'hlist', :partial => 'index' 
	  end
  end
  
  def ajax_edit

   	@header = ItemDisbursement.find(params[:id])
  	_init
  	render :update do |page|
		  page.replace_html 'hlist', :partial => 'index' 
	  end
  end 
  
  # @params
  # header, items, search
  def ajax_create
   begin
      @assign_items = params[:items]
      
      project_id = params[:header][:project_id]
      employee_id = params[:header][:employee_id]
      
      @disbursement = ItemDisbursement.find(:first, :conditions => { :employee_id => employee_id, :project_id => project_id })
      
      unless @disbursement
        @disbursement = ItemDisbursement.create(params[:header])
      end
      
      
      ItemRelease.transaction do
          
          # save items
          for assign_item in @assign_items
          
            item = Item.find(assign_item[:item_id], :select => ['id, current_qty'])
            qty =  assign_item[:qty]
            is_returnable = assign_item[:is_returnable]
            
            ii = ItemRelease.find(:first, 
                                  :conditions => { :item_disbursement_id => @disbursement.id,
                                                    :item_id => item.id
                                           })
            
            raise StandardError if qty.to_i > item.current_qty
            
            if ii
              # just do update
              ii.update_attributes(:last_borrowed_qty => qty, :qty => ii.qty.to_i + qty.to_i)
            else
              # create the item
              item_release = ItemRelease.create :item_disbursement_id => @disbursement.id,
                                                :item_id => item.id,
                                                :qty => qty,
                                                :last_borrowed_qty => qty,
                                                :is_returnable => is_returnable,
                                                :released_at => Time.now
            end # end of if
          end # end of for

         # session[:items] = []
          
          @borrowed_items = ItemDisbursement.find_by_id(@disbursement.id) \
                                            .item_releases.find(:all, :order => ['updated_at DESC'] )
        
          render :update do |page|
            page << "alert('Item Assignment was successfully created!')"
            page << "$('#list').html('#{ escape_javascript( render :partial => 'assign_item_list') }')"
            page << "$('#borrowed_item_list_table').html('#{ escape_javascript( render :partial => 'user_borrowed_item_list_table') }')"
          end
                
      end # end of transaction
    
    rescue StandardError, Exception => exec
      
      #raise ActiveRecord::Rollback
      
      render :update do |page|
        page << "alert('Please check form for any correction!')"
      end
      
#      raise ActiveRecord::Rollback, 'Weve got rollback here!'
      

      
    end
    
          
  end 
   
  def ajax_update
  	begin
  	    @item_assignment = ItemRelease.find(params[:id])

  	
		render :update do |page|
			if @item_assignment.update_attributes(params[:item_assignment])
				@item_assignments = ItemRelease.find(:all)
				page.replace_html 'list', :partial => 'list'
			else
	            page.replace_html 'message_area', error_messages_for(:item_assignment)
	       end
		end
    	rescue ActiveRecord::RecordNotFound => e
    	render :update do |page|
           page.replace_html 'message_area', "Record not found: #{params[:id]}"
        end
    end
  end
  
  def ajax_delete
  	@item_assignment = ItemDisbursement.find(params[:id])

    
    render :update do |page|
	  	if @item_assignment.destroy
	  		@headers = ItemDisbursement.find(:all)

	  		page.replace_html 'hlist', :partial => 'list'
	  	end
	end
  end
  
  def _init
  	@projects = Project.find(:all, :include => [:client], :select => "id, clients.name as name")
  	man_powers = ManPowerAssignment.find(:all, :conditions => { :project_id => @projects.first })
  	
  	@employees = Employee.find(:all, :conditions => ["id IN(?)", man_powers.collect(&:employee_id)])
  	@items = Item.all(:limit => 3, :conditions => ['current_qty > 0'])
  	
  	@borrowed_items = []
  end
 
  # ajax item list
  def ajax_item_list
  	search = params[:search] if params[:search]
  	@items = Item.find(:all, :conditions => ['name LIKE ?', "%#{search}%"])
  	render :update do |page|
			page.replace_html 'item_list_table', :partial => 'item_list_table' 
	  end
  end
  
  def remove_assigned_item
    item_id =  params[:item_id]
    
    session[:items].delete(item_id.to_i)
         
    render :update do |page|
      page << "$('#assigned_item_#{item_id}').remove()"
    end
    
  end
  
  def add_item
#    session[:items] = [] unless session[:items].empty?
    
  	@item = Item.find(params[:id])
  	
  	if @item.current_qty < 1
      # if below qty
      render :update do |page|
        page << "alert('Item is not available')"
      end
  	elsif  session[:items].has_key?(@item.id)
  	  # if exist?
  	  render :update do |page|
  	    page << "alert('Item is Already Added to the Project')"
  	  end
  	  
  	else  
      session[:items].merge!( { @item.id => @item.name })
            
    	render :update do |page|
    	  page << "jQuery('#message_area').slideUp()"
    		page.insert_html :bottom, 'assigned_item_row', 
    			"<tr id='assigned_item_#{@item.id}'>
  				<td>
  				    <b>#{@item.name}</b>
  				    <div class='ssub'>
    					    Brand: #{@item.brand.name if @item.brand}
    					</div>
  				</td>
  				<td align=center>
              #{@item.barcode}
  				</td>
  				<td align=center>#{@item.current_qty}</td>
  				<td align=center>
  					<input type='text' value='1' style='text-align: center;' size='1' name='items[][qty]' id='item_qty'>
  					<input type='hidden' value='#{@item.id}' name='items[][item_id]'>
  				</td>
  				<td align='center'>
  				  #{@item.type_of}
  				</td>
  				<td>
  				  #{link_to_function image_tag('delete.png'), "remove_assigned_item(" + @item.id.to_s + ")"}
  				</td>
  				
  				</tr>"
  			page << "clearSearchAndFocus()"
    	end
    end
  end
  
  def update_borrower_tag
    
    session[:items] = {}
    
    @project = Project.find_by_id(params[:project_id])
    
  	man_powers = ManPowerAssignment.find(:all, :conditions => { :project_id => @project.id })

  	@employees = Employee.find(:all, :conditions => ["id IN(?)", man_powers.collect(&:employee_id)])
  	
  	render :update do |page|
  	  #page << "$('#list').html('#{ escape_javascript( render :partial => 'assign_item_list') }')"
  	  page << "$('#borrower_list').html('#{ escape_javascript(render :partial => 'form_borrower_name') }')"
  	end
  	
  end
  
  def update_borrowed_item
    
    session[:items] = {}
    
    @borrowed_items = []
    @disbursement = ItemDisbursement.find_by_project_id_and_employee_id(params[:project_id], params[:employee_id])
    @borrowed_items = @disbursement.item_releases.find(:all, :order => ['updated_at DESC'] ) if @disbursement
    
    render :update do |page|
      #page << "$('#list').html('#{ escape_javascript( render :partial => 'assign_item_list') }')"
      page << "$('#borrowed_item_list_table').html('#{ escape_javascript( render :partial => 'user_borrowed_item_list_table') }')"
    end
  end
  
  
  def search_item
    barcode = params[:barcode].to_i
  	@search = params[:search]
  	
  	@items = Item.find(:all, :conditions => ['name LIKE :value OR serial_number LIKE :value OR barcode LIKE :value', 
  	                                          { :value => "%#{@search}%" }], :limit => 3, :include => [:accessories])
           
    render :update do |page|
      page << "$('#item_list_table').html('#{ escape_javascript(render :partial => 'item_list_table') }')" 

      if barcode == 1
        page << "$('#click_#{@items[0].id}').trigger('click')" 
      end  
    end
    
                      
  end
  
end
