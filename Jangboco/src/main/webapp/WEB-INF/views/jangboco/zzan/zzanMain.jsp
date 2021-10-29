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
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=9a34fa20b8bdbafa1061701c69f892c1&libraries=services,clusterer"></script>
<script type="text/javascript" src="resources/script/layout/addrsMapApi.js"></script>

<style>
.con {
    width: 100%;
    height: 100%;
    font-family: 'Noto Sans KR', sans-serif;
    font-size: 11pt;
    font-weight: 400;
}

.zzan_head_contnr {
	width: 100%;
    height: 80px;
    display: flex;
}

.zzan_title {
	width: 200px;
    height: 100%;
    display: flex;
    margin-left:20px;
}

.zzan_event {
	width: calc(100% - 220px);
    height: 100%;
    display: flex;
}

.zzan_main_contnr {
	width: 100%;
    height: calc(100% - 80px);
    display: flex;
}

.zzan_side_contnr {
	width: 200px;
    height: 100%;
    display: flex;
    border: 2px solid #03A64A;
    border-radius: 20px;
    margin-right: 5px;
}

.zzan_search {
	width: 50px;
    height: 30px;
    display: flex;
}

.zzan_list {
	width: calc(100% - 50px);
    height: 100%;
    display: flex;
}

.zzan_map_contnr {
	width: calc(100% - 200px);
    height: 100%;
    border: 2px solid #03A64A;
    border-radius: 20px;
    padding: 5px;
    display: flex;
}

.zzan_map {
	width: 100%;
    height: 100%;
    display: flex;
    border-radius: 20px;
}

#prsnt_map{
	position: absolute;
	left: 40%;
	top: 7px; 
	color: #666666;
	z-index: 10;
	font-size: 15px;
	font-weight: bold;
	background: white;
	box-shadow: 1px 1px 1px 1px #AAAAAA;
	padding: 0px 7px;
	border-radius: 4px;
	cursor: pointer;
}
</style>

</head>
<body>
<c:import url="/layoutTopLeft"></c:import>
<main>
	<form action="#" id="go_form" method="post">
      	<input type="hidden" name="member_no" value="${memberNo}">
		<input type="hidden" id="home_flag" name="home_flag" value="${homeFlag}">
		<input type="hidden" id="menu_idx" name="menu_idx" value="${menuIdx}">
		<input type="hidden" id="sub_menu_idx" name="sub_menu_idx" value="${subMenuIdx}">
	</form>
    <div class="con_contnr">
    	<div class="con">
    
    
    
    <div class="zzan_head_contnr">
    	<div class="zzan_title">
    		<h2> 우리동네 가격비교 </h2>
    	</div>
    	
    	<div class="zzan_event">
    		<p>인기있는 행사 리스트...</p>
   		</div>
    </div>
    
    
    
    <div class="zzan_main_contnr">
	    <div class="zzan_side_contnr">
	    	<div class="zzan_search">
	    
	    	</div>
	    	
	    	<div class="zzan_list">
	    		<p>리스트는 여기에</p>
	   		</div>
	    </div>
	    
	    <div class="zzan_map_contnr">
	    	<div class="zzan_map" id="map">
			<button id="prsnt_map">현재지도에서 보기</button>
			</div>
    	</div>
    </div>
          
	
	<script>
	
	$(document).ready(function() {
		//서울시 폴리곤 그리기
		$.getJSON("resources/json/seoul.json",function(geojson){
			var data = geojson.features;
			var coordinates = []; //좌표 저장할 배열
			var name=''; //이름
			
			$.each(data,function(index,val){
				coordinates = val.geometry.coordinates;
				name = val.properties.CTP_KOR_NM;
				displayArea(coordinates, name);	
			})
		})
		
	});
	
	
	<%--기본 지도 정보--%>

	
	var map = new kakao.maps.Map(document.getElementById('map'), { // 지도를 표시할 div
        center : new kakao.maps.LatLng(36.2683, 127.6358), // 지도의 중심좌표 
        level : 9 // 지도의 확대 레벨 
    });
	var bounds= new kakao.maps.LatLngBounds();//바운드객체
	
	var imageSrc =
		"resources/images/zzan/marker.png",
		imageSize = new kakao.maps.Size(30, 33),
		imageOption = {
		offset: new kakao.maps.Point(15, 33)
		};//커스텀 마커 설정
	var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize, imageOption);
	var markers=[];
	
	
	
	<%--클러스터, 마커 정보--%>
		
		
	// 마커 클러스터러를 생성합니다 
    var clusterer = new kakao.maps.MarkerClusterer({
        map: map, // 마커들을 클러스터로 관리하고 표시할 지도 객체 
        averageCenter: true, // 클러스터에 포함된 마커들의 평균 위치를 클러스터 마커 위치로 설정 
        minLevel: 7, // 클러스터 할 최소 지도 레벨 
        calculator: [5, 10, 30], // 클러스터의 크기 구분 값, 각 사이값마다 설정된 text나 style이 적용된다 
        styles: [{ // calculator 각 사이 값 마다 적용될 스타일을 지정한다
                width : '35px', height : '35px',
                background: 'rgba(128, 145, 255, .6)',
                borderRadius: '17.5px',
                color: '#000',
                textAlign: 'center',
                fontWeight: 'bold',
                lineHeight: '31px'
            },
            {
                width : '48px', height : '48px',
                background: 'rgba(255, 137, 85, .5)',
                borderRadius: '24px',
                color: '#000',
                textAlign: 'center',
                fontWeight: 'bold',
                lineHeight: '41px'
            },
            {
                width : '56px', height : '56px',
                background: 'rgba(255, 73, 73, .5)',
                borderRadius: '28px',
                color: '#000',
                textAlign: 'center',
                fontWeight: 'bold',
                lineHeight: '51px'
            },
            {
                width : '60px', height : '60px',
                background: 'rgba(255, 80, 80, .5)',
                borderRadius: '30px',
                color: '#000',
                textAlign: 'center',
                fontWeight: 'bold',
                lineHeight: '61px'
            }
        ]
    });
	
	
	
	<%--내 위치 정보--%>
	
	
	var userImgSrc =
		"resources/images/zzan/user-location.png",
		userImgSize = new kakao.maps.Size(40, 40),
		userImgOption = {
		offset: new kakao.maps.Point(20, 40) 
		};//사용자 위치 커스텀 마커 이미지 설정
	
	var locMarkerImage = new kakao.maps.MarkerImage(userImgSrc, userImgSize, userImgOption)
	//사용자 위치 커스텀 마커이미지 사용
	
	var locMarker = new kakao.maps.Marker({
         position: new kakao.maps.LatLng(33.450705, 126.570677),
         image: locMarkerImage //사용자 위치 커스텀 마커 설정
     });
	
	
	<%--내 위치로 좌표,마커 표시하기--%>
	
	
	$('#main_loc_addrs').on('DOMSubtreeModified', function() {
		
		locMarker.setMap(null);//내 위치 초기화
		
		bounds = new kakao.maps.LatLngBounds();
		map.setBounds(bounds);//지도범위 초기화
		
		// 주소-좌표 변환 객체를 생성합니다
		var geocoder = new kakao.maps.services.Geocoder();
		
		// 주소로 좌표를 검색합니다
		geocoder.addressSearch($("#main_loc_addrs").text(), function(result, status) {

		    // 정상적으로 검색이 완료됐으면 
		     if (status === kakao.maps.services.Status.OK) {
		        var coords = new kakao.maps.LatLng(result[0].y, result[0].x); //주소로 좌표값 가져오기
		        var disct = result[0].address.region_2depth_name; //주소로 구 정보 가져오기
		        console.log(disct);
		        locMarker.setPosition(coords); //해당좌표로 마커이동
		        locMarker.setMap(map); //지도에 마커 표시
		        // 인포윈도우로 장소에 대한 설명을 표시합니다
		        var infowindow = new kakao.maps.InfoWindow({
		            content: '<div style="width:150px;text-align:center;padding:6px 0;">내 위치</div>'
		        });
		        
		        kakao.maps.event.addListener(locMarker, 'mouseover', function() {
		        	infowindow.open(map, locMarker);
	            });//마우스오버이벤트

	            kakao.maps.event.addListener(locMarker, 'mouseout', function() {
	                infowindow.close();
	            }); 
	     

		        // 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
		        bounds.extend(coords);
		        
		        //기존에 있던 마커들 지우기
		        markers=[];
		        clusterer.clear();
		        
		        
		        <c:forEach var="data" items="${list}">
			    	if(disct=='${data.DISCT_NAME}'){
			    		var marker = new kakao.maps.Marker({
				        	position : new kakao.maps.LatLng(${data.LAT}, ${data.LNG}),
				    		image: markerImage
				   	 	});
				    	
			    		markers.push(marker);
			    		bounds.extend(new kakao.maps.LatLng(${data.LAT}, ${data.LNG}));
			    	}
				</c:forEach>
				clusterer.addMarkers(markers); //클러스터에 마커 추가
				
				
				map.setBounds(bounds, 90, 30, 10, 30);//지도범위 설정
		        
		    } 
		}); 
		
		
	    });//DOMSubtreeModified end
	    
	    
	    
	<%--현재 위치로 좌표,마커 표시하기--%>

		
	$("#prsnt_map").click(function() {
		//기존에 있던 마커들 지우기
        markers=[];
        clusterer.clear();
		
        
        // 지도의 현재 영역을 얻어옵니다 
	    var prsntBounds = map.getBounds();
	    
	    // 영역의 남서쪽 좌표를 얻어옵니다 
	    var swLatLng = prsntBounds.getSouthWest(); 
	    
	    // 영역의 북동쪽 좌표를 얻어옵니다 
	    var neLatLng = prsntBounds.getNorthEast(); 
	    
	    
	    var message = '지도의 남서쪽 좌표는 ' + swLatLng.getLat() + ', ' + swLatLng.getLng() + ' 이고 <br>';
	    message += '북동쪽 좌표는 ' + neLatLng.getLat() + ', ' + neLatLng.getLng() + ' 입니다';
	    
	    console.log(message);
        
        
		<c:forEach var="data" items="${list}">
		var marker = new kakao.maps.Marker({
	        	position : new kakao.maps.LatLng(${data.LAT}, ${data.LNG}),
	    		image: markerImage
	   	 	});
		
		if(prsntBounds.contain(new kakao.maps.LatLng(${data.LAT}, ${data.LNG}))){
			markers.push(marker);
    	}	
 		
		</c:forEach>
		clusterer.addMarkers(markers); //클러스터에 마커 추가
		
		
		
		
	})//prsnt_map event end 
	
    
	
	<%--지도 레벨 제한하기--%>

	
	// 지도 확대 축소를 제어할 수 있는  줌 컨트롤을 생성합니다
	var zoomControl = new kakao.maps.ZoomControl();
	map.addControl(zoomControl, kakao.maps.ControlPosition.RIGHT);
	map.setMaxLevel(9);
	

	<%--지도 영역 제한하기--%>
	/* kakao.maps.event.addListener(map, 'bounds_changed', function() {             
	    
	    // 지도 영역정보를 얻어옵니다 
	    var bounds = map.getBounds();
	    // 영역정보의 남서쪽 정보를 얻어옵니다 
	    var swLatlng = bounds.getSouthWest();
	    // 영역정보의 북동쪽 정보를 얻어옵니다 
	    var neLatlng = bounds.getNorthEast();
	    
	    var message = '<p>영역좌표는 남서쪽 위도, 경도는  ' + swLatlng.toString() + '이고 <br>'; 
	    message += '북동쪽 위도, 경도는  ' + neLatlng.toString() + '입니다 </p>'; 
	    
	    console.log(message);
	    console.log(swLatlng.La);
	    console.log(swLatlng.Ma);
	    
	    if(swLatlng.La < 123.47535976257261){
	    	swLatlng.La = 123.47535976257261;
	    }
	    
	    map.setBounds(bounds); */
	    
	    /* var sw = new kakao.maps.LatLng(36, 127),
	    ne = new kakao.maps.LatLng(37, 128);

		var bounds2 = new kakao.maps.LatLngBounds(sw, ne); // 인자를 주지 않으면 빈 영역을 생성한다. */
	//});


	
	//행정구역 폴리곤 그리기
	function displayArea(coordinates, name){
		var path=[]; //폴리곤 그려줄 path
		
		$.each(coordinates[0],function(index, coordinate) {
			//console.log(coordinates)를 확인해보면 [0]번째에 배열이 주로 저장이됨. 그래서 [0]번째 배열에서 꺼내줌.
				path.push(new daum.maps.LatLng(coordinate[1],coordinate[0]));
		})
		
		// 지도에 표시할 다각형을 생성합니다
		var polygon = new kakao.maps.Polygon({
		    path:path, // 그려질 다각형의 좌표 배열입니다
		    strokeWeight: 9, // 선의 두께입니다
		    strokeColor: '#088A4B',//'#004c80', // 선의 색깔입니다
		    strokeOpacity: 0.6, // 선의 불투명도 입니다 1에서 0 사이의 값이며 0에 가까울수록 투명합니다
		    //fillColor: '#fff', // 채우기 색깔입니다
		    //fillOpacity: 0.7 // 채우기 불투명도 입니다
		});

		polygon.setMap(map);
		
	}
	
	</script>
        </div>
    </div>
    <div class="bottom_contnr"></div>
</main>
</body>
</html>