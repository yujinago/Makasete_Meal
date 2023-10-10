// ラジオボタンの変更を監視する
function setupRadioButtonChangeHandler() {
  $('input[type="radio"][name="restaurant[location_choice]"]').on('change', function() {
    if ($(this).val() === "1") {
      // 位置情報を取得する
      navigator.geolocation.getCurrentPosition(successCallback, errorCallback);
    } else {
      // ラジオボタンが選択されていない場合、位置情報を非表示にする
      $('#location-info').hide();
      
      // ラジオボタンが選択されていない場合、latitudeとlongitudeフィールドに初期値を設定する
      $('#latitude').val('');
      $('#longitude').val('');
    }
  });
}

// ページ読み込み時に実行する
$(document).on('turbolinks:load', function() {
  // ラジオボタンの変更を監視する関数を呼び出す
  setupRadioButtonChangeHandler();
});

// 取得に成功した場合の処理
function successCallback(position) {
  // 緯度を取得し画面に表示
  var latitude = position.coords.latitude;
  $('#latitude').val(latitude);
  $('#latitude-display').html(latitude);
  // 経度を取得し画面に表示
  var longitude = position.coords.longitude;
  $('#longitude').val(longitude);
  $('#longitude-display').html(longitude);
  // 位置情報を表示する要素を表示
  $('#location-info').show();
}

// 取得に失敗した場合の処理
function errorCallback(error) {
  alert("位置情報が取得できませんでした。");
}