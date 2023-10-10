// 大エリア選択の変更があったときに実行する
$(document).on('change', '#large_area_results', function() {
  // Ajaxリクエストを送信して、中エリアの選択肢を更新する
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