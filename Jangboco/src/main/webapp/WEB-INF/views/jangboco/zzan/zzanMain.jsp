<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="preconnect" href="https://fonts.gstatic.com">
<link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100;300;400;500;700;900&display=swap">
<link rel="stylesheet" type="text/css" href="resources/css/layout/default.css">
<script type="text/javascript" src="resources/script/jquery/jquery-1.12.4.min.js"></script>
<script type="text/javascript" src="resources/script/jquery/jquery.form.js"></script>
<script type="text/javascript" src="resources/script/layout/default.js"></script>
<script type="text/javascript" src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=9a34fa20b8bdbafa1061701c69f892c1&libraries=services"></script>
<script type="text/javascript" src="resources/script/layout/addrsMapApi.js"></script>
</head>
<body>
<c:import url="/layoutTopLeft"></c:import>
<main>
    <div class="con_contnr">
        <div class="con">
           
	<div id="map2" style="width:1730px;height:780px;">
	<p class="btn-init" onclick="setBounds()" style="position: absolute;right: 7px;bottom: 7px;
	color: #666666;z-index: 10;font-size: 12px;font-weight: bold;background: white;box-shadow: 1px 1px 1px 1px #AAAAAA;padding: 0px 7px;border-radius: 4px;cursor: pointer;">초기화면으로</p>
	<!-- 초기화면 버튼 클릭하면 바운드값 초기화 -->
	<button id="mapinfo" onclick="getInfo()" style="position: absolute;right: 100px;bottom: 15px; color: #666666;z-index :9999;">현재지도 정보얻기</button>
	</div>
	<script src="//dapi.kakao.com/v2/maps/sdk.js?appkey=61c8c8efc790452c5140ffc9ec95d67e&libraries=services"></script>
	<script>
	<%--기본 지도 그리기--%>
	
	var mapContainer2 = document.getElementById('map2'), // 지도를 표시할 div
	mapOption2 = {
	center: new kakao.maps.LatLng(33.850701, 126.870667), // 지도의 중심좌표
	level: 3 // 지도의 확대 레벨
	};
	// 지도를 표시할 div와 지도 옵션으로 지도를 생성
	var map2 = new kakao.maps.Map(mapContainer2, mapOption2);
	
	<%-- 키워드로 검색해서 장소id,좌표 얻어오기--%>
	
	var inputData = ['흑석시장','은로초등학교'] //검색키워드...실제로는 키워드앞에 지역붙여야할듯
	
	// 장소 검색 객체를 생성
	var ps = new kakao.maps.services.Places();
	var bounds2 = new kakao.maps.LatLngBounds();//바운드객체
	var imageSrc =
		"https://tistory2.daumcdn.net/tistory/3056305/skin/images/map-marker-red.png",
		imageSize = new kakao.maps.Size(35, 35),
		imageOption = {
		offset: new kakao.maps.Point(17, 40) //옵셋이 뭐지??????
		};
	var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize, imageOption)
	//커스텀 마커 디자인 설정
	
	var count = 0;
	if (inputData != null) { //이건 굳이 왜 하는거지?????
		kewwordSearch(inputData[count]);
		}

	function kewwordSearch(keword) {
		ps.keywordSearch(keword, placesSearchCB);// 키워드로 장소를 검색
		count = count + 1;
		}

	function placesSearchCB(data, status, pagination) {// 키워드 검색 완료 시 호출되는 콜백함수
		if (status === kakao.maps.services.Status.OK) {
			displayMarker(data[0]);//마커설정
			bounds2.extend(new kakao.maps.LatLng(data[0].y, data[0].x));//지도표시범위
			if (count < inputData.length) {
				kewwordSearch(inputData[count]);
			} else if (count == inputData.length) {
				setBounds();
			}
		}
	}
	<%--검색 완료시 호출되는 콜백 함수는 data, status, pagination 3개의 매개변수를 입력받습니다. 키워드로 검색된 장소에 대한 데이터는 data에 저장되어 있습니다. 키워드로 검색된 결과는 복수이기 때문에 data는 배열입니다. 이 data 객체로부터 장소 ID 이외에 다양한 장소에 대한 정보를 얻을 수 있습니다.

	data 객체 주요 프로퍼티
	id : 장소 ID
	place_name : 장소명, 업체명
	category_name : 카테고리 이름
	phone : 전화번호
	address_number : 지번 주소
	road_address_name : 전체 도로명 주소
	x : X 좌표값, 경위도인 경우 경도
	y : 좌표값, 경위도인 경우 위도 --%>
	
	function displayMarker(place) {
		var marker = new kakao.maps.Marker({
			map: map2,
			position: new kakao.maps.LatLng(place.y, place.x),
			image: markerImage //커스텀마커 이미지로
		});
		kakao.maps.event.addListener(marker, 'click', function () {
			var position = this.getPosition();
			var url = 'https://map.kakao.com/link/map/' + place.id;
			window.open(url, '_blank');
		});
		var content =
			'<div class="customoverlay" style="position: relative;bottom: 76px;border-radius: 6px;border: 1px solid #ccc;border-bottom: 2px solid #ddd;float: left;">' +
			' <a href="https://map.kakao.com/link/map/' + place.id + '"' +
			' target="_blank" style="display: block;text-decoration: none;color: #666666;text-align: center;border-radius: 6px;font-size: 14px;font-weight: bold;overflow: hidden;background: #d95050;background: #d95050 url(https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/arrow_white.png) no-repeat right 14px center;">' +
			' <span class="title" style="display: block;text-align: center;background: #fff;margin-right: 35px;padding: 8px 10px;font-size: 13px;font-weight: bold;">' +
			count + '. ' + place.place_name + '</span>' +
			' </a>' +
			'</div>';
			var customOverlay = new kakao.maps.CustomOverlay({
				map: map2,
				position: new kakao.maps.LatLng(place.y, place.x),
				content: content,
				yAnchor: 0.11  //머지???
		});//마커 내용 커스텀 
		
	}

	function setBounds() {
		map2.setBounds(bounds2, 90, 30, 10, 30);
	}
	
	
	<%--주소로 좌표 가져오기--%>
	
	// 주소-좌표 변환 객체를 생성합니다
	var geocoder = new kakao.maps.services.Geocoder();

	// 주소로 좌표를 검색합니다
	geocoder.addressSearch('서울시 동작구 서달로 10나길 6', function(result, status) {

	    // 정상적으로 검색이 완료됐으면 
	     if (status === kakao.maps.services.Status.OK) {

	        var coords = new kakao.maps.LatLng(result[0].y, result[0].x);

	        // 결과값으로 받은 위치를 마커로 표시합니다
	        var marker3 = new kakao.maps.Marker({
	            map: map2,
	            position: coords
	        });

	        // 인포윈도우로 장소에 대한 설명을 표시합니다
	        var infowindow = new kakao.maps.InfoWindow({
	            content: '<div style="width:150px;text-align:center;padding:6px 0;">현재위치</div>'
	        });
	        infowindow.open(map2, marker3);

	        // 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
	        //map2.setCenter(coords);//바운드때문에 안먹히는듯
	    } 
	}); 
	
	<%--지도정보 가져오기(좌표가져오려고)--%>
	
	function getInfo() {
	    // 지도의 현재 중심좌표를 얻어옵니다 
	    var center = map2.getCenter(); 
	    
	    // 지도의 현재 레벨을 얻어옵니다
	    var level = map2.getLevel();
	    
	    // 지도타입을 얻어옵니다
	    var mapTypeId = map2.getMapTypeId(); 
	    
	    // 지도의 현재 영역을 얻어옵니다 
	    var bounds3 = map2.getBounds();
	    
	    // 영역의 남서쪽 좌표를 얻어옵니다 
	    var swLatLng = bounds3.getSouthWest(); 
	    
	    // 영역의 북동쪽 좌표를 얻어옵니다 
	    var neLatLng = bounds3.getNorthEast(); 
	    
	    // 영역정보를 문자열로 얻어옵니다. ((남,서), (북,동)) 형식입니다
	    var boundsStr = bounds3.toString();
	    
	    
	    var message = '지도 중심좌표는 위도 ' + center.getLat() + ', <br>';
	    message += '경도 ' + center.getLng() + ' 이고 <br>';
	    message += '지도 레벨은 ' + level + ' 입니다 <br> <br>';
	    message += '지도 타입은 ' + mapTypeId + ' 이고 <br> ';
	    message += '지도의 남서쪽 좌표는 ' + swLatLng.getLat() + ', ' + swLatLng.getLng() + ' 이고 <br>';
	    message += '북동쪽 좌표는 ' + neLatLng.getLat() + ', ' + neLatLng.getLng() + ' 입니다';
	    
	    // 개발자도구를 통해 직접 message 내용을 확인해 보세요.
	    console.log(message);
	    
	    <%-- 마커로 잘 되는지 확인해보기
	    var marker4 = new kakao.maps.Marker({
	        map: map2,
	        position: new kakao.maps.LatLng(swLatLng.getLat(), swLatLng.getLng())
	    });
	    var marker5 = new kakao.maps.Marker({
	        map: map2,
	        position: new kakao.maps.LatLng(neLatLng.getLat(), neLatLng.getLng())
	    });

	    // 인포윈도우로 장소에 대한 설명을 표시합니다
	    var infowindow = new kakao.maps.InfoWindow({
	        content: '<div style="width:150px;text-align:center;padding:6px 0;">지도의 남서쪽 좌표</div>'
	    });
	    infowindow.open(map2, marker4);
	    
	    var infowindow2 = new kakao.maps.InfoWindow({
	        content: '<div style="width:150px;text-align:center;padding:6px 0;">지도의 북동쪽 좌표</div>'
	    });
	    infowindow2.open(map2, marker5);
	    --%>
	}

	getInfo();
	
	
	<%--지도 레벨 제한하기--%>
	// 지도 확대 축소를 제어할 수 있는  줌 컨트롤을 생성합니다
	var zoomControl = new kakao.maps.ZoomControl();
	map2.addControl(zoomControl, kakao.maps.ControlPosition.RIGHT);

	// 지도가 확대 또는 축소되면 마지막 파라미터로 넘어온 함수를 호출하도록 이벤트를 등록합니다
	kakao.maps.event.addListener(map2, 'zoom_changed', function() {        
	    
	    // 지도의 현재 레벨을 얻어옵니다
	    var level = map2.getLevel();
	    
	    if (level>9){
	    	map2.setLevel(level - 1); //지도 레벨이 9보다 크면 레벨 1개 줄임
	    }
	});
	
	<%--행정구역 구별하기--%>
	
	//행정구역 구분
	$.getJSON("resources/json/seoul_map.json",function(geojson){
		var data = geojson.features;
		var coordinates = []; //좌표 저장할 배열
		var name=''; //행정 구 이름
		
		$.each(data,function(index,val){
			coordinates = val.geometry.coordinates;
			name = val.properties.SIG_KOR_NM;
			displayArea(coordinates, name);	
		})
	})
	
	//행정구역 폴리곤
	function displayArea(coordinates, name){
		var path=[]; //폴리곤 그려줄 path
		
		$.each(coordinates[0],function(index, coordinate) {
			//console.log(coordinates)를 확인해보면 [0]번째에 배열이 주로 저장이됨. 그래서 [0]번째 배열에서 꺼내줌.
			if(name="동작구"){
				console.log(name);
				path.push(new daum.maps.LatLng(coordinate[1],coordinate[0]));
			}
		})
		
		// 지도에 표시할 다각형을 생성합니다
		var polygon = new kakao.maps.Polygon({
		    path:path, // 그려질 다각형의 좌표 배열입니다
		    strokeWeight: 5, // 선의 두께입니다
		    strokeColor: '#004c80', // 선의 색깔입니다
		    strokeOpacity: 0.3, // 선의 불투명도 입니다 1에서 0 사이의 값이며 0에 가까울수록 투명합니다
		    //fillColor: '#fff', // 채우기 색깔입니다
		    //fillOpacity: 0.7 // 채우기 불투명도 입니다
		});

		// 지도에 다각형을 표시합니다
		polygon.setMap(map2);
	}
	
	
	
	

	</script>
        </div>
    </div>
    <div class="bottom_contnr"></div>
</main>
</body>
</html>