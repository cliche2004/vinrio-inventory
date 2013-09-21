class PurchaseOrdersController < ApplicationController
  before_filter :_init
  after_filter :_init
 
  def index
    session[:po_item_id] = []
  	@purchase_orders = PurchaseOrder.new
  	_init
    render :partial => 'index'
  end

  def ajax_list
    @headers = PurchaseOrder.find(:all)

  	render :update do |page|
			page.replace_html 'hlist', :partial => 'po_list' 
	  end
  end

  def ajax_new
  	@purchase_order = PurchaseOrder.new
  	render :update do |page|
		  page.replace_html 'hlist', :partial => 'index' 
	  end
  end

  def ajax_edit
   	@header = PurchaseOrder.find(params[:id])
  	_init
  	render :update do |page|
		  if @header
			  page.replace_html 'hlist', :partial => 'edit' 
	    end
	  end
  end 

  def ajax_create
    @po_items = params[:items]
    @purchase_order = PurchaseOrder.new(params[:header])
    
    render :update do |page|
	    PurchaseOrder.transaction do
	      if @purchase_order.save
	        # save items
	        for po_items in @po_items
	          
	          item_id = po_items[:item_id]
	          qty = po_items[:qty]
	          unit_price = po_items[:unit_price]
	          
	          po_detail = PurchaseOrderDetail.create :purchase_order_id => @purchase_order.id,
	                                            :supplier_id => @purchase_order.supplier_id,
	                                            :item_id => item_id,
	                                            :qty => qty,
	                                            :unit_price => unit_price,
	                                            :created_at => Time.now
	        end

      		    page.replace_html 'hlist', :partial => 'index'
				page.replace_html 'message_area', "P.O Successfully Created"
  		  page << "jQuery('#message_area').slideDown()"
	      else
  		 	    page.replace_html 'message_area', error_messages_for(:purchase_order)
		  	    page << "jQuery('#message_area').slideDown()"
		  end
        end
     end
  end 

  def ajax_update
  	@purchase_order = PurchaseOrder.find(params[:id])
  	
	  render :update do |page|
		  if @purchase_order.update_attributes(params[:purchase_order])
			  _init
			  page.replace_html 'hlist', :partial => 'list'
		  else
          page.replace_html 'message_area', error_messages_for(:purchase_order)
          page << "jQuery('#message_area').slideDown()"
        end
	    end
  end
  
  def ajax_delete
  	@purchase_order = PurchaseOrder.find(params[:id])
    
    render :update do |page|
	  	if @purchase_order.destroy
	  		@headers = PurchaseOrder.find(:all)
	  		page.replace_html 'hlist', :partial => 'po_list'
	  	end
	  end
  end
  
  def remove_po_assigned_item
    item_id =  params[:item_id]
    
    session[:po_item_id].delete(item_id)
    
    logger.debug(session[:po_item_id].inspect)
    
    render :update do |page|
      page << "$('#assigned_item_#{item_id}').remove()"
    end
    
  end
  
  def add_item
  	@item = Item.find(params[:id])
  	
  	if session[:po_item_id].include?(@item.id)
  	  
  	  # render error
  	  render :update do |page|
  	    page.replace_html 'message_area', "Item Already Added"
  		  page << "jQuery('#message_area').slideDown()"
  	  end
  	  
  	else  
      
      session[:po_item_id] << @item.id
      
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
  					<input type='text' value='0.00' style='text-align: center;' size='5' name='items[][unit_price]' id='item_price'>
  				</td>
  				<td align=center>
  					<input type='text' value='1' style='text-align: center;' size='5' name='items[][qty]' id='item_qty'>
  					<input type='hidden' value='#{@item.id}' name='items[][item_id]'>
  				</td>
  				<td align=center>
   				    <a onclick=\"jQuery.ajax({data:'', dataType:'script', type:'post', url:'/purchase_orders/get_suppliers/" + @item.id.to_s + "'}); return false;\" href=\"#\"><img title=\"supplier\" src=\"/images/list-icon.png\"></a>
  				</td>
  				<td>
  				  #{link_to_function image_tag('delete.png'), "remove_po_assigned_item(" + @item.id.to_s + ")"}
  				</td>
  			</tr>"
    	end
    end
  end
  
  def get_suppliers
	render :update do |page|
		page << "window.open('/purchase_orders/top_suppliers/#{params[:id]}', 'Item Suppliers #{params[:id]}',
		'left=20,top=20,width=300,height=300,toolbar=0,res izable=0' );"
		end
  end
  
  def top_suppliers
  	    @low_price = SupplierPriceHistory.find(:all, :conditions => ["item_id = #{params[:id]}"], :include => [:supplier], :limit => '3', :order => 'price ASC')
  	    @high_price = SupplierPriceHistory.find(:first, :conditions => ["item_id = #{params[:id]}"], :include => [:supplier], :order => 'price DESC')
  	    
  		render :partial => 'supplier_list'
  end
  
  def ajax_search
  	@search = params[:search]
  	@items = Item.find(:all, :conditions => ['name LIKE :value OR serial_number LIKE :value OR barcode LIKE :value', 
  	                                          { :value => "%#{@search}%" }])
    
    render_update_page('list', 'item_list', {})
  end
 
  private
   
  def _init
  	@headers = PurchaseOrder.find(:all)
  	@items = Item.all(:limit => 5)
  	@suppliers = Supplier.find(:all, :select => ['id, name'])
  	@contacts = Supplier.find(:first).supplier_contacts
  end
  
end
