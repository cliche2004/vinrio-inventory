
function format_currency(num) {
	num = num.toString().replace(/\$|\,/g,'');
	
	if(isNaN(num))
		num = "0";
		
	sign = (num == (num = Math.abs(num)));
	num = Math.floor(num*100+0.50000000001);
	cents = num%100;
	num = Math.floor(num/100).toString();
	
	if(cents<10)
		cents = "0" + cents;
		
	for (var i = 0; i < Math.floor((num.length-(1+i))/3); i++)
		num = num.substring(0,num.length-(4*i+3))+','+
		num.substring(num.length-(4*i+3));
	
	return (((sign)?'':'-') + '' + num + '.' + cents);
}

function calculate_discount(discount) {
	amount = isNaN($('sub_total').value)?0:$('sub_total').value;
	disc = discount > 0?(discount / 100):0;
	total_discount = amount * disc;
	$('net_amount').innerHTML = format_currency(amount - total_discount);
}

function calculate_change(sub_total, discount, amount_received, id) {
	disc = discount > 0?(discount / 100):0;
	total_discount = sub_total * disc;
	net_amount = parseFloat(sub_total) - parseFloat(total_discount);
	change = amount_received - net_amount;
	$(id).innerHTML = (format_currency(change) <= 0) ? '0' : format_currency(change) ;
}

function calculate_price(o,process) {
	if (process) o.value = format_currency(o.value);
}

function calculate_amount(qty, price, id) {
	amount = qty * price;
	$(id).innerHTML = amount.toFixed(2);
}

function calculate_total(amount) {
	var sub_total=0;
	for (var i=0; i<amount.length;i++) {
		sub_total += parseFloat($('amount['+amount[i]+']').innerHTML);
	}
	
	discount = 0;
	if (discount > 0) {
		total = sub_total - ((discount / 100) * sub_total);
	} else {
		total = sub_total;
	}
	if (sub_total.toFixed) {
		$('sub_total').innerHTML = sub_total.toFixed(2);
		$('total').innerHTML = total.toFixed(2);
	}
}

function compute_srp_and_unit_price(amount, free, qty, mark_up, srp_id, unit_price_id) {
	unit_price = parseFloat(amount/(qty-free));
	srp = unit_price + parseFloat(unit_price * mark_up);
	//$(srp_id).innerHTML = srp.toFixed(2);
	//$(unit_price_id).innerHTML = unit_price.toFixed(2);
	
	for (var i=1; i<10;i++) {
		amount_total += parseFloat($('amount['+[i]+']').innerHTML);
	  qty_total += parseFloat($('qty['+[i]+']').innerHTML);
		expense_total += parseFloat($('expense['+[i]+']').innerHTML);
	}
	$('t_amount').innerHTML = amount_total.toFixed(2);
	$('t_qty').innerHTML = qty_total.toFixed(2);
  $('t_expense').innerHTML = expense_total.toFixed(2);
}

function compute_srp_and_price(amount) {
	var sub_total=0;
	for (var i=0; i<amount.length;i++) {
		sub_total += parseFloat($('price['+amount[i]+']').value);
	}
	alert(amount);
	$('t_amount').innerHTML = sub_total.toFixed(2);
}

function compute_sales() {
	var total=0;
	jQuery('span[@is_amount=true]').each(function() {
		total += parseFloat(this.innerHTML);
	})
	$('total').innerHTML = total.toFixed(2);
	$('order_total').value = total.toFixed(2);
}

var Items = new Array();

function popuponclick() {
	my_window = window.open("/reports/items_by_rack_number/ajax_display_items",
    "Items","status=1,width=800,height=600");
}

function remove_element(element_id) {
	jQuery(element_id).remove();
}

function calculate_with_discount(sub_total, discount, id){
	disc = discount > 0 ? (discount / 100) : 0;
	total_discount = sub_total * disc;
	net_amount = parseFloat(sub_total) - parseFloat(total_discount);
	$(id).innerHTML = (format_currency(net_amount) <= 0) ? '0' : format_currency(net_amount);
}

/** Additional Functionalities */

// the trId is used to retrieve the row where the item belongs
function measurementHandler(o) {
	var rowId = "tr#"+Ext.get(o).dom.parentNode.parentNode.id;
	var tr = Ext.select(rowId);
	var mSelector = rowId + " select";
	var qSelector = rowId + " input";
	// measurement
	var m = Ext.select(mSelector).elements[0];
	console.log(Ext.select(mSelector));
	var price = Ext.get(m.options[m.selectedIndex]).dom.attributes.price.nodeValue;
	// set the price column
	tr.elements[0].cells[2].innerHTML = Ext.util.Format.money(price);
	updateTotals();
}

function updateTotals() {
	var rows = Ext.select("tbody#t_list tr");
	if (rows.elements.length <= 0) return;
	var total = 0;
	for (var i=0; i<rows.elements.length; i++) {
		var el = rows.elements[i];
		var tr = Ext.get(rows.elements[i]);
		var price = tr.dom.cells[2].innerHTML.to_f();
		var qty = Ext.get(Ext.select("tr#" + el.id + " input").elements[0]).dom.value.to_f();
		var partial = price * qty;
		total += partial;
		tr.dom.cells[6].innerHTML = Ext.util.Format.money(partial);
	}
	Ext.get('total').dom.innerHTML = Ext.get('order_total').dom.value = Ext.util.Format.money(total);
	updateChange();
}

function updateChange() {
	var total = Ext.get('total').dom;
	var amount = Ext.get('amount').dom;
	var change = Ext.get('change').dom;
	change.innerHTML = Ext.util.Format.money(amount.value.to_f() - total.innerHTML.to_f());
}

/*
function addItem(obj) {


		
	t.append('t_list',{name:'test', discount:'0', price:'0.00', qty_left:'0', select:'<% item.conversions.each do |c| %>
						'<option value="<%= c.measurement_id %>" price="<%= c.price %>" qty="<%= c.qty %>">',
						'<%= c.measurement.name %></option><% end %>', amount:'0.00'});
}
*/
