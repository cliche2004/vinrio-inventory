class UsersController < ApplicationController  

   def index
  	@users = User.find(:all)
    render :partial => 'index'
  end

  def ajax_list
  	@users = User.find(:all)
  	render :update do |page|
		page.replace_html 'list', :partial => 'list' 			
	end
  end
  
  
  def ajax_new
 	@user = User.new
 	
  	render :update do |page|
		page.replace_html 'list', :partial => 'new' 
	end
  end

    def ajax_edit
   	@user = User.find(params[:id])
  	render :update do |page|
		page.replace_html 'list', :partial => 'edit' 
	end
  end 
  
	 def ajax_create
	  	@user = User.new(params[:user])
	  	@user.is_admin = true if params[:user][:is_admin] == '1'
	 	  	
		render :update do |page|
			if @user.save
				@users = User.find(:all)
				page.replace_html 'list', :partial => 'list'
			else
			  page.replace_html 'message_area', error_messages_for(:user)
			  page << "jQuery('#message_area').slideDown()"
			end
		end
	 end 
 
  
  def ajax_update
  	@user = User.find(params[:id])
  	
	render :update do |page|
		if @user.update_attributes(params[:user])
			@users = User.find(:all)
			flash[:notice] = "Updated Successfuly."
			page.replace_html 'list', :partial => 'list'
		else
		  page.replace_html 'message_area', error_messages_for(:user)
		  page << "jQuery('#message_area').slideDown()"
    	end
	end
  end
  
  def ajax_delete
  	@user = User.find(params[:id])
    
    render :update do |page|
	  	if @user.destroy
	  		@users = User.find(:all)
	  		page.replace_html 'list', :partial => 'list'
	  	end
	end
  end
  
  def _init
  	@user = UserType.find(:all)
  	@users = User.find(:all)
  end
end
