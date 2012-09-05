/* # Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
ahh but I dont WANT to use coffeescript!
*/

$(document).ready(function() {

  var work_order =  {

    init: function(options) {
      // TODO extract these handlers into a jquery plug in
      // modal_association or something...
      this.setup_product_handlers();
      this.setup_comment_handlers();
    },
    setup_product_handlers: function() {
      $('#work_order_product_modal').live('hidden', function() {
        $(this).remove();
      });

      $('.add-work-order-product').live('ajax:success', function(xhr, data, status) {
        $(data).modal({ backdrop: false });
      });
      
      $('.new_work_order_product').live('ajax:success', function(xhr, data, status) {
        $('#work_order_product_modal').modal('hide');
        $('#work_order_products tbody').append($(data));
      });

      $('#work_order_product_modal form').live('ajax:error', function(xhr, data, status) {
        $('#work_order_product_modal').modal('hide');
        $(data.responseText).modal({ backdrop: false });
      });

      $('.delete-work-order-product').live('ajax:success', function(xhr, data, status) {
        $(this).closest('.work-order-product').remove();
      });

      $('.edit_work_order_product').live('ajax:success', function(xhr, data, status) {
          el = $(data);
          $('#' + el.attr('id')).replaceWith(el);
          $('#work_order_product_modal').modal('hide');
      });

      $('.edit-work-order-product').live('ajax:success', function(xhr, data, status) {
        $(data).modal({ backdrop: false });
      });
    },
    setup_comment_handlers: function() {
      $('#comment_modal').live('hidden', function() {
        $(this).remove();
      });

      // Show the form for a new comment
      $('.add-comment').live('ajax:success', function(xhr, data, status) {
        $(data).modal('show');
      });

      // handle errors in both the edit and add forms
      $('#comment_modal form').live('ajax:error', function(xhr, data, status) {
        $('#comment_modal').modal('hide');
        $(data.responseText).modal({backdrop: false});
      });

      // handle successful new comment addition
      $('.new_comment').live('ajax:success', function(xhr, data, status) {
        $('#comments').prepend($(data));
        $('#comment_modal').modal('hide');
      });

      // show form for editing comment
      $('.edit-comment').live('ajax:success', function(xhr, data, status) {
        $(data).modal('show');
      });

      // handle successful comment edit 
      $('.edit_comment').live('ajax:success', function(xhr, data, status) {
          el = $(data);
          $('#' + el.attr('id')).replaceWith(el);
          $('#comment_modal').modal('hide');
      });

      // handle deleting a comment
      $('.delete-comment').live('ajax:success', function(xhr, data, status) {
        $(this).closest('.comment').remove();
      });

    },

    payment_fields: function() {
      return $('#payment_info input[type!=radio], #payment_info select, #payment_info .btn');
    },
    enable_payment : function() { 
      this.payment_fields().each(function() { 
        $(this).removeAttr('disabled'); 
      });
    },
    disable_payment : function() { 
      this.payment_fields().each(function() { 
        $(this).attr('disabled', 'disabled'); });
    },

    add_billing_address: function(data) {
      // console.log(data);
      data.client_id = $('#work_order_client_id').val();
      data = { billing_address: data };
      console.log(data);

      $.ajax({
        url: "/billing_addresses",
        type: "POST",
        data: data,
        success:function() { work_order.get_client();}
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
      if($("#work_order_user_pays_false").attr('checked')) {
        $('#work_order_payment_attributes_bill_to').val(client.local_name);
      }
      // billing addresses{O
    },

    // ajax call to get client and thier billing addresses
    get_client: function() {
      jQuery.getJSON('/clients/'+$('#work_order_client_id').val(), work_order.set_client);
    }
  };

  $('#work_order_client_id').change(function() {
    work_order.get_client();
  });
  $('#add_billing_address').click(function() {
    if($(this).attr('disabled') == 'disabled') {
      return;
    }
    var billing_address = new ModalEditForm({ model: 'billing_address', callback: function(data) { work_order.add_billing_address(data); } });
    billing_address.show();
  });

  $('#work_order_user_pays_false').click(function() { work_order.enable_payment(); });
  $('#work_order_user_pays_true').click(function() { work_order.disable_payment(); });
  if($('#work_order_user_pays_true').attr('checked')) {
    work_order.disable_payment();
  }
  $('#payment_deadline').datepicker();
  $('#paid_on_date_picker').datepicker();
  work_order.init();

});
