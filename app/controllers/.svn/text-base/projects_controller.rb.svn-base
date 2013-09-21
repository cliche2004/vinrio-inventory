class ProjectsController < ApplicationController

  def index
   	@projects = Project.find(:all, :order => ["created_at DESC"], :conditions => { :status => 'OPEN' })
    render :partial => 'index'
  end

  def ajax_list
  	search = params[:project][:name] if params[:project]
  	
  	if search
  	
  	  @projects = Project.find( :all, 
  	                            :conditions => ["project_unique_id LIKE ? AND status = 'OPEN'", "%#{search}%"], 
  	                            :order => ["created_at DESC"])
  	else
  	  @projects = Project.find(:all, :order => ["created_at DESC"], :conditions => { :status => 'OPEN' })
  	end
  	
  	render :update do |page|
			page.replace_html 'list', :partial => 'list' 
	  end
	  
  end
  
  def ajax_new
  	@project = Project.new
  	@clients = Client.find(:all)
  	@engineers = Employee.find(:all, :conditions => { :designation => 'Engineer' })
  	
  	render :update do |page|
		  page.replace_html 'list', :partial => 'new' 
	  end
  end

  def ajax_edit
   	@project = Project.find(params[:id])
   	@clients = Client.find(:all)
    @engineers = Employee.find(:all, :conditions => { :designation => 'Engineer' })
   	
   	render_update_page('list', 'edit')
  end 
  
  
  def ajax_create
  	@project = Project.new(params[:project])

  	  	
	  if @project.save
      @users = Employee.borrowers
      @assigned_users = @project.man_powers.find(:all, :include => [:employee])

      render_update_page('list', 'add_user', {})
      
	  else
	    render :update do |page|
		    page.replace_html 'message_area', error_messages_for(:project)
		    page << "jQuery('#message_area').slideDown()"
	    end
	  end
  end 
  
   
  def submit_user_problem_report
	  @problem = Problem.new(params[:problem])
	  @problem.project_id = params[:project_id]
	  
	  render :update do |page|
		  if @problem.save
				@project = Project.find(params[:project_id])
				@problems = @project.problems.find(:all, :include => :employee)	
		  
				page.replace_html 'problem_list', :partial => 'user_list_problem'
				page.replace_html 'message_area', "Employee Report Successfully Created"
  		  page << "jQuery('#message_area').slideDown()"
				
		  else
			  page.replace_html 'message_area', error_messages_for(:problem)
			  page << "jQuery('#message_area').slideDown()"
		  end
	  end
	  
  end 

  def ajax_update
  	@project = Project.find(params[:id])
  	
	  render :update do |page|
		  if @project.update_attributes(params[:project])
			  @projects = Project.find(:all, :conditions => { :status => 'OPEN' })
			  page.replace_html 'list', :partial => 'list'
		  else
          page.replace_html 'message_area', error_messages_for(:project)
          page << "jQuery('#message_area').slideDown()"
        end
	    end
  end
  
  def user_assignment
  	@project = Project.find(params[:id])  	
  	@users = Employee.borrowers
  	@assigned_users = @project.man_powers.find(:all, :include => [:employee])
  	
  	render_update_page('list', 'add_user', {})
  end
   
  def user_problem_report
  	@project = Project.find(params[:id])  	
  	@assigned_users = @project.employees
  	@problems = @project.problems(:all, :include => [:employee])
  	
  	render_update_page('list', 'assigned_problem')
  end
   
  def ajax_delete
  	@project = Project.find(params[:id])
    render :update do |page|
	  	if @project.destroy
	  		@projects = Project.find(:all, :conditions => { :status => 'OPEN' })
	  		page.replace_html 'list', :partial => 'list'
	  	end
	  end
  end
  
  def delete_assigned_user
    
   	@project = Project.find(params[:project_id])
   	user = @project.man_powers.find(:first, :conditions => {:id => params[:id] })
 	
 		if user.destroy
			@assigned_users = @project.man_powers.find(:all, :include => [:employee])
			render_update_page('user_assigned_holder', 'assigned_users', {}, 'Assigned Employee is successfully deleted')
 		else
      
 		end
 		
  end
  
  def search_users
  	@user = params[:user]
    project_id = params[:project_id]
  	
    @project = Project.find(:first, :conditions => { :id => project_id, :status => 'OPEN' }, :select => 'id')
  	@users = Employee.search_borrower(@user)
  	
  	render_update_page('user_list_table', 'user_list_table', {})

#  	render :update do |page|
#  		page.replace_html 'user_list_table', :partial => 'user_list_table'
#  	end
  end
    
  def ajax_assigned_user
  	employee = Employee.find(params[:id])	
  	@project = Project.find(params[:project_id])
  	
  	if @project.man_powers.find(:first, :conditions => { :employee_id => employee.id })
  		# message if user already assigned to this project
  		render :update do |page|	
	  		  page.replace_html 'message_area', "Employee #{employee.full_name} already assigned to this project"
        	page << "jQuery('#message_area').slideDown()"
	  	end 	
  	else
  		# create the user ...
	  	@project.man_powers.create( :employee_id => employee.id )
	  	@assigned_users = @project.man_powers.find(:all, :include => [:employee])
	  	
	  	render :update do |page|	
	  		page.replace_html 'user_assigned_holder', :partial => 'assigned_users'	  		
	  	end 	
  	end
  end
  
end
