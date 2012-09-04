$(document).ready(function() {
  $('.reload-picker').live('ajax:success', function(xhr, data, status) {
    $('.reload-picker').closest('.picker').replaceWith($(data));
  });
  $('.reload-picker').click();
});
