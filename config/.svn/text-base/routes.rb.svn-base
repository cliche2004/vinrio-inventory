ActionController::Routing::Routes.draw do |map|
  map.home '/', :controller => 'sessions', :action => 'new'
  
  map.logout '/logout', :controller => 'sessions', :action => 'destroy'
  map.login '/login', :controller => 'sessions', :action => 'new'
#  map.register '/signup', :controller => 'users', :action => 'create'
  map.signup '/users', :controller => 'users', :action => 'index'
  
  map.dashboard '/home', :controller => 'home', :action => 'index'
 
 
  map.resource :users
  map.resource :session

  # The priority is based upon order of creation: first created -> highest priority.

  # Sample of regular route:

  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   map.purchase 'products/:id/purchase', :controller => 'catalog', :action => 'purchase'
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   map.resources :products
    
  map.resources :tools
  map.resources :consumables 
  map.resources :item_assignments
  map.resources :purchase_orders
  map.resources :purchase_recieves
  map.resources :item_returns
  map.resources :personnel_returns
  
  map.resources :item_types
  map.resources :measurements
  map.resources :brands
  map.resources :storage_locations
  map.resources :suppliers
  map.resources :contact_types
  map.resources :projects
  map.resources :supplier_contacts
  map.resources :employees
  map.resources :clients
  
  map.remove_assigned_item 'item_assignments/remove_assigned_item', :controller => 'item_assignments', :action => 'remove_assigned_item'
  map.remove_po_assigned_item 'purchase_orders/remove_po_assigned_item', :controller => 'purchase_orders', :action => 'remove_po_assigned_item'
  map.get_suppliers 'purchase_orders/get_suppliers', :controller => 'purchase_orders', :action => 'get_suppliers'

	map.resources :item_masters, :controller => 'reports/item_masters'
	map.resources :per_persons, :controller => 'reports/per_persons'
	map.resources :per_projects, :controller => 'reports/per_projects'
	map.resources :per_tools, :controller => 'reports/per_tools'
	map.resources :consumable_items, :controller => 'reports/consumable_items'
	map.resources :withdrawal_per_persons, :controller => 'reports/withdrawal_per_persons'
	map.resources :usage_per_projects, :controller => 'reports/usage_per_projects'

	map.resources :tool_items, :controller => 'tool_reports/item_masters'
	map.resources :tool_per_persons, :controller => 'tool_reports/per_persons'
	map.resources :tool_per_projects, :controller => 'tool_reports/per_projects'
	map.resources :tool_per_tools, :controller => 'tool_reports/per_tools'
	map.resources :tool_withdrawal_per_persons, :controller => 'tool_reports/withdrawal_per_persons'
	map.resources :tool_usage_per_projects, :controller => 'tool_reports/usage_per_projects'

	map.resources :consumable_per_persons, :controller => 'consumable_reports/per_persons'
	map.resources :consumable_per_projects, :controller => 'consumable_reports/per_projects'
	map.resources :consumable_per_tools, :controller => 'consumable_reports/per_tools'
	map.resources :consumable_items, :controller => 'consumable_reports/consumable_items'
	map.resources :consumable_withdrawal_per_persons, :controller => 'consumable_reports/withdrawal_per_persons'
	map.resources :consumable_usage_per_projects, :controller => 'consumable_reports/usage_per_projects'
	
  # Sample resource route with options:
  #   map.resources :products, :member => { :short => :get, :toggle => :post }, :collection => { :sold => :get }

  # Sample resource route with sub-resources:
  #   map.resources :products, :has_many => [ :comments, :sales ], :has_one => :seller
  
  # Sample resource route with more complex sub-resources
  #   map.resources :products do |products|
  #     products.resources :comments
  #     products.resources :sales, :collection => { :recent => :get }
  #   end

  # Sample resource route within a namespace:
  #   map.namespace :admin do |admin|
  #     # Directs /admin/products/* to Admin::ProductsController (app/controllers/admin/products_controller.rb)
  #     admin.resources :products
  #   end

  # You can have the root of your site routed with map.root -- just remember to delete public/index.html.
  #map.root :controller => "home"

  # See how all your routes lay out with "rake routes"

  # Install the default routes as the lowest priority.
  # Note: These default routes make all actions in every controller accessible via GET requests. You should
  # consider removing or commenting them out if you're using named routes and resources.
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end