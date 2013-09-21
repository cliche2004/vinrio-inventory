class ToolsController < ApplicationController
  
  def index
  	@items = Item.find(:all, :conditions => { :type_of => Item::ITEMTYPE })
    render :partial => 'index'
  end

  def ajax_list
  	@search = params[:search]
  	if @search
    	@items = Item.find(:all, 
    	                   :conditions => ["name LIKE :value OR 
    	                                    serial_number LIKE :value OR 
    	                                    barcode LIKE :value AND 
    	                                    type_of LIKE 'Item'", 
    	                                  { :value => "%#{@search}%" }])
  	else
  	  @items = Item.find(:all, :conditions => { :type_of => Item::ITEMTYPE })
  	end
    
    render_update_page('list', 'list', {})
  
  #	render :update do |page|
	#		page.replace_html 'list', :partial => 'list' 
	#  end
  end
  
  def ajax_new
  	@item = Item.new
  	_init
  	render :update do |page|
		  page.replace_html 'list', :partial => 'new' 
	  end
  end

  def ajax_edit
   	@item = Item.find(params[:id])
  	_init
  	
  	render :update do |page|
		  if @item
			  page.replace_html 'list', :partial => 'edit' 
	    end
	  end
  end 
  
  def ajax_create
  	@item = Item.new(params[:item])
  	@item.type_of =   "Tools"
  	
  	Item.transaction do  	
	    render :update do |page|
  		  if @item.save
		      
		      if params[:items]
  		      accessories = params[:items]
		      
  		      # create accessories
  		      for accessory in accessories
  		        @item.accessories.create :name => accessory[:accessory] if accessory
  		      end
  		    end
		    
  			  @items = Item.find(:all, :conditions => { :type_of => Item::ITEMTYPE })
  			  page.replace_html 'list', :partial => 'list' 			
  		  else
  			  page.replace_html 'message_area', error_messages_for(:item)
  			  page << "jQuery('#message_area').slideDown()"
  		  end
  	  end
  	end
  end 
   
  def ajax_update
  	@item = Item.find(params[:id])
  	
  	Item.transaction do
	    render :update do |page|
  		  if @item.update_attributes(params[:item])
		      
		      @item.accessories.delete_all
  		    #update accessories
  		    
  		    if params[:items]
  		      accessories = params[:items]
		      
  		      for accessory in accessories
  		        @item.accessories.create :name => accessory[:accessory] if accessory
  		      end
  		    end
		    
  			  @items = Item.find(:all, :conditions => { :type_of => Item::ITEMTYPE })
  			  page.replace_html 'list', :partial => 'list'
  		  else
            page.replace_html 'message_area', error_messages_for(:item)
            page << "jQuery('#message_area').slideDown()"
          end
  	    end
  	  end
  end
  
  def ajax_delete
  	@item = Item.find(params[:id])
    
    render :update do |page|
	  	if @item.destroy
	  		@items = Item.find(:all, :conditions => { :type_of => Item::ITEMTYPE })
	  		page.replace_html 'list', :partial => 'list'
	  	end
	  end
  end
  
  
  def add_accessory
  	render :update do |page|
  		page.insert_html :top, 'item_accessories', 
  			"<div class='field-holder'>
    			<div id='form-field'>
    			  <input type='text' name='items[][accessory]' size='30'>
    			  #{link_to_function image_tag('icons/delete.png'), '$(this).parent().parent().remove()'}
    			</div>
        </div>"
  	end
  end
  
  
  private
  
  def _init
  	@units = Measurement.find(:all)
  	@storage_locations = StorageLocation.find(:all)
  	@brands = Brand.find(:all)
  end
  

end
