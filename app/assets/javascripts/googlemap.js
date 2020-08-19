// 店舗新規登録画面
// Mapの表示
//マップオブジェクト
var gMap = null;
//マーカーオブジェクト
var gMarkerCenter = null;

function initMap(){
 // 緯度経度から地図を表示
  var lat = $('#restaurant_latitude').val();
  var lng = $('#restaurant_longitude').val();
// 座標を設定
  var myLatLng = new google.maps.LatLng(lat, lng)
  var mapOptions = {
    center: myLatLng,
    zoom: 15,
    mapTypeId: google.maps.MapTypeId.ROADMAP
  };
// マップオブジェクトの生成、マーカー生成
  gMap = new google.maps.Map(document.getElementById("map"), mapOptions);
  gMarkerCenter = drawMarkerCenterInit(myLatLng);
}
// マーカー生成関数
function drawMarkerCenterInit(pos) {
  var markerCenter = new google.maps.Marker({
    position: pos,
    map: gMap,
    draggable: true
 });
  return markerCenter;
}

// レストランページで地図を表示
$(function(){
  handler = Gmaps.build('Google');
  handler.buildMap({ provider: { scrollwheel: false }, internal: {id: 'map'}}, function(){
    markers = handler.addMarkers([
      {
        "lat": 0,
        "lng": 0,
    "infowindow":  "hello!"
      }
    ]);
    handler.bounds.extendWith(markers);
    handler.fitMapToBounds();
    handler.getMap().setZoom(16);
  });
});