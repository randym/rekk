/* # Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
ahh but I dont WANT to use coffeescript!
 */
$(document).ready(function() {

  var work_order =  {

    init: function(options) {

    },
    add_billing_address: function(data) {
      // console.log(data);
      data['client_id'] = $('#work_order_client_id').val()
      var data = { billing_address: data }
      console.log(data)
      
      $.ajax({
	      url: "/billing_addresses",
	      type: "POST",
	      data: data,
        success:function() { work_order.get_client()}
       });
      
    },
    // update dependant ui elements 
    set_client: function(client) {
      // console.log(client)
      $('#client_memo').text(client.memo);
      $('#work_order_payment_attributes_billing_address_id').empty();
      $.each(client.billing_addresses, function(index, address) {
        $('#work_order_payment_attributes_billing_address_id')
        .append($('<option>')
                .attr('value', address.id)
                .text(address.company_name));
      } );// org memo
      // billing addresses
    },

    // ajax call to get client and thier billing addresses
    get_client: function() {
      jQuery.getJSON('/clients/'+$('#work_order_client_id').val(), work_order.set_client)
    }
  };

  $('#work_order_client_id').change(function() {
    work_order.get_client()
  });
  $('#add_billing_address').click(function() {
    var billing_address = new ModalEditForm({ model: 'billing_address', callback: function(data) { work_order.add_billing_address(data) } })
    billing_address.show()
  });
});
