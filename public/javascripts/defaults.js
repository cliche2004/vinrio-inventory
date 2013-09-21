function render(purl,div_id) {	
	$.ajax({
	  url: purl,
	  type: 'GET',
	  success: function(data) {
	    $('#'+div_id).html(data);
	  }
	});
}