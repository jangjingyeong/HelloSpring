<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>네이버 지도 API</title>
		 <script type="text/javascript" src="https://oapi.map.naver.com/openapi/v3/maps.js?ncpClientId=hubphkkpaf&submodules=geocoder"></script>
	</head>
	<body>
		<h1>네이버 지도 Api 사용해보기</h1>
		<div id="root" style="width:100%;height:400px;"></div>
		<script>
			var mapOptions = {
			    center: new naver.maps.LatLng(37.5679212, 126.9830358),
			    zoom: 17
			};
			var map = new naver.maps.Map('root', mapOptions);
			
			var markerOptions = {
				position : new naver.maps.LatLng(37.5679212, 126.9830358),
				map : map
			}
			var marker = new naver.maps.Marker(markerOptions);
			
			var content = "<div>content</div>"
			var infoWindowOptions = {
				content : content
			}
			var infoWindow = new naver.maps.InfoWindow(infoWindowOptions);
			infoWindow.open(map, marker);
			
			// 이벤트 연결
			naver.maps.Event.addListener(map, "click", function(e) {
// 				alert("clicked!"); // 연결 확인 
// 				console.log(e); // 정보 확인 
				// 마커 옮기기 
				marker.setPosition(e.coord); 
				
				// 위도, 경도로 주소 가져오기
				naver.maps.Service.reverseGeocode({
					location : new naver.maps.LatLng(e.coord.lat(), e.coord.lng())
				}
					, function(status, response) {
						var result = response.result;
						var items = result.items;
						var address = items[1].address;
						console.log(address);
						content = address;
					});
				
				// 인포윈도우 열려있으면 닫고 마커 옮기면 다른 거 뜸 
				if(infoWindow != null) { // null이 아니고 
					if(infoWindow.getMap()) { // 열려있으면 
						infoWindow.close();
						infoWindow = new naver.maps.InfoWindow({
							content : content
						});
						infoWindow.open(map, marker);
					}
				}
			});
			
			// 이벤트 연결2 
			naver.maps.Event.addListener(marker, "click", function(e) {
// 				alert("marker clicked!"); // 연결 확인 
				// 마커 클릭하면 인포윈도우 띄우기
// 				infoWindow.open(map, marker);
				if(infoWindow != null) { // null이 아니고 
					if(infoWindow.getMap()) { // 열려있으면 
						infoWindow.close();
					} else {
						infoWindow.open(map, marker);
					}
				}
			});
		</script>
	</body>
</html>