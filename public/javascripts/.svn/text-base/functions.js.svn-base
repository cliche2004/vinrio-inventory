//Javascript pre define functions

/*load_view = function(url) {
	$('#view-content').render(url);
} */

function render(purl,div_id) {	
	jQuery.ajax({
	  url: purl,
	  type: 'GET',
	  success: function(data) {
	    jQuery('#'+div_id).html(data);
	  }
	});
	
}


// search textbox
simple_search = function(id, url){
	
 $('#'+id).keyup(function(event) { 

       jQuery.ajax({
     	  url: url,
     	  type: 'POST',
     	  data: "search="+$('#'+id).val(),
     	  success: function(data) {}
     	})

   })
}


update_borrowed_item = function(assigned_item_id, rqty){
	jQuery.ajax({
	   url: '/item_returns/update_borrowed_item',
  	  type: 'POST',
  	  data: { rqty: rqty, assigned_item_id: assigned_item_id },
  	  success: function(data) {} 
	 })
}

// remove item from item assignment

remove_assigned_item = function(item_id){

	jQuery.ajax({
	  url: "/item_assignments/remove_assigned_item",
	  type: 'POST',
	  data: { item_id: item_id },
	  success: function(data) {
    
	  }
	});

}

remove_po_assigned_item = function(item_id){
	jQuery.ajax({
	  url: "/purchase_orders/remove_po_assigned_item",
	  type: 'POST',
	  data: { item_id: item_id },
	  success: function(data) {
    
	  }
	});
}





popUp_login = function() {
	// a workaround for a flaw in the demo system (http://dev.jqueryui.com/ticket/4375), ignore!
	$( "#dialog:ui-dialog" ).dialog( "destroy" );
	
	$( "#dialog-modal" ).dialog({
		height: 250,
		modal: true
	});

}

updateBreadcrumb = function(txt) {
	 jQuery('#breadCrumbTxt').html(txt);
}

function showInfo(purl,div_id,id) {
	jQuery('#loader').show();
	
	jQuery.ajax({
	  url: purl,
	  type: 'POST',
	  data: "item_id=" + id,
	  success: function(data) {
	    jQuery('#loader').hide();
	    jQuery('#'+div_id).html(data);
	  } 	
	});	
}


updateBorrowerSelect = function(project_id){
	jQuery('#loader').show();
	
	jQuery.ajax({
	  url: 'item_assignments/update_borrower_tag',
	  type: 'POST',
	  data: "project_id=" + project_id,
	  success: function(data) {
	    jQuery('#loader').hide();
	  } 	
	});
	
}

updateBorrowedItem =  function(project_id, employee_id){
	jQuery('#loader').show();

	jQuery.ajax({
	  url: 'item_assignments/update_borrowed_item',
	  type: 'POST',
	  data: "project_id=" + project_id + "&employee_id=" + employee_id,
	  success: function(data) {
	    jQuery('#loader').hide();
	  } 	
	});
	
}



assignItem = function(id){
	jQuery.ajax({
	  url: '/item_assignments/add_item',
	  type: 'POST',
	  data: { id: id }
	});
}

clearSearchAndFocus = function(){
	$('#search').val('');
	$('#search').focus();
	
}

assignItemToEmployee = function(){
	
	jQuery.ajax({
	   url: '/item_assignments/ajax_create',
  	  type: 'POST',
  	  data: $('#item_assignment_form').serialize()
	 })
	 
	 return false;
}

