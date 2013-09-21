class PurchaseRecievesController < ApplicationController
 
  def index
    session[:po_item_id] = []
  	@headers = PurchaseOrder.find(:all)
    render :partial => 'index'
  end
  
  def ajax_list
    @headers = PurchaseOrder.find(:all)

  	render :update do |page|
			page.replace_html 'hlist', :partial => 'po_list' 
	  end
  end

 def ajax_recieve
      @header = PurchaseOrder.find(params[:id])

  	  render :update do |page|
			  page.replace_html 'hlist', :partial => 'confirm_recieving'
	  end
  end  

  def ajax_confirm_recieve
   	@header = PurchaseOrder.find(params[:id])
   	purchase_order = { :status => "Recieve" }

  	   render :update do |page|
		  if @header.update_attributes(purchase_order)
		  	  @headers = PurchaseOrder.find(:all)
			  page.replace_html 'hlist', :partial => 'po_list'
		  else
         	  page.replace_html 'message_area', error_messages_for(:header)
         	  page << "jQuery('#message_area').slideDown()"
        end
	  end
  end  

  def ajax_print_po
	render :update do |page|
		page << "window.open('/purchase_recieves/get_po_list/#{params[:id]}', 'P.O #{params[:id]}',
		'left=20,top=20,width=500,height=700,toolbar=0,res izable=0' );"
		end
  end
  
  def get_po_list
  	    @header = PurchaseOrder.find(params[:id])
  		render :partial => 'print_po'
  end
  
end
