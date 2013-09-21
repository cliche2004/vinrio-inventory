class Reports::ItemMastersController < ApplicationController
	
   def index
   	session[:report_items] = {}
   	
  	@items = Item.find(:all, :conditions => {:type_of => Item::ITEMTYPE})
  	_init
    render :partial => 'index'
  end
  
  def export_list
  	item = session[:report_items].empty? ? [] : session[:report_items]
  	
  	search = item[:search] ? item[:search] : ''
  	brand_id = item[:brand_id] ? item[:brand_id] : ''
  	type_name = Item::ITEMTYPE
  	
    items = Item.find(:all, :conditions => ['name LIKE ? AND brand_id LIKE ? AND type_of LIKE ?', "%#{search}%","%#{brand_id}%","%#{type_name}%"])
    
    csv_string = FasterCSV.generate do |csv| 
    	
		csv << Item.csv_header
			items.each do |c|
		    csv << [c.barcode, c.serial_number, c.name, c.comments, c.current_qty, c.measurement && c.measurement.name, c.brand && c.brand.name, c.status]
		    end 
    end
    
    send_data csv_string, :type => "text/csv", 
     :filename => "Item_Master_#{Date.today.strftime('%d%b%y')}.csv", 
     :disposition => 'attachment'
  end
  
  def ajax_item_search
  	item = params[:item]
  	session[:report_items] = params[:item]
  	
  	search = item[:search] ? item[:search] : ''
  	brand_id = item[:brand_id] ? item[:brand_id] : ''
  	type_name = Item::ITEMTYPE
  	
  	@items = Item.find(:all, :conditions => ['name LIKE ? AND brand_id LIKE ? AND type_of LIKE ?', "%#{search}%","%#{brand_id}%","%#{type_name}%"])
  	
  	render :update do |page|
			page.replace_html 'list', :partial => 'list' 
	  end
  end
  
  private
  
  def _init
  	@brands = Brand.find(:all)
  	@types = Item::TYPEOF
  end
end
