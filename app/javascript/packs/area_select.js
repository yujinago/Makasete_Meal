$(document).on('change', '#large_area_results', function() {
  $.ajax({
    type: 'GET',
    url: '/restaurants/middle_area_select',
    data: {
      restaurant_large_area: $(this).val()
    },
    success: function(data) {
      $('#middle_area_results').html(data);
    }
  });
});