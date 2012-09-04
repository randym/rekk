$(document).ready(function() {
  $('#work_order_product_product_picker').bind('change', function() {
    var tokens = $(this).val().split(' ');
    if (tokens.length === 0) { return; }
    var fee = tokens[tokens.length - 1];
    if (isNaN(fee)) { fee = ""; }
    $('#work_order_product_fee').val(fee);
  });
   $('#work_order_product_is_fixed_schedule_true').bind('click', function() {
    $('#fixed_schedule_controls').show();
    $('#rolling_schedule_controls').hide();
  });
  $('#work_order_product_is_fixed_schedule_false').bind('click', function() {
   $('#fixed_schedule_controls').hide();
   $('#rolling_schedule_controls').show();
  });
});
