<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="resources/script/jquery/jquery-1.12.4.min.js"></script>
<script type="text/javascript" src="resources/script/jquery/jquery.form.js"></script>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=9a34fa20b8bdbafa1061701c69f892c1&libraries=services"></script>
</head>
<body>

	<script>	
	
	<%-- 키워드로 검색해서 장소id,좌표 얻어오기--%>
	
	//var inputData = ['흑석시장','은로초등학교'] //검색키워드...실제로는 키워드앞에 지역붙여야할듯
	var inputData = new Array();
	<c:forEach var="data" items="${list}">
	inputData.push('${data.DISCT_NAME} ${data.MARKET_NAME}');
	</c:forEach>
	console.log(inputData.length)
	
	// 장소 검색 객체를 생성
	var ps = new kakao.maps.services.Places();

	var count = 0;
	if (inputData != null) { //이건 굳이 왜 하는거지?????
		for(var i=0;i<inputData.length;i++){
			kewwordSearch(inputData[count]);
			count = count + 1;
			}
		}

	function kewwordSearch(keword) {
		ps.keywordSearch(keword, placesSearchCB);// 키워드로 장소를 검색
		}

	function placesSearchCB(data, status, pagination) {// 키워드 검색 완료 시 호출되는 콜백함수
		if (status === kakao.maps.services.Status.OK) {
			리스트에 해쉬맵만들어서 데이터 넣어야함. 해쉬맵은 마켓네임 주소 위도 경도
			console.log(data[0].place_name, data[0].road_address_name,data[0].x,data[0].y);
			
			
		} else if (status === kakao.maps.services.Status.ZERO_RESULT) {

			console.log('검색 결과가 존재하지 않습니다.');
	        return;

	    } else if (status === kakao.maps.services.Status.ERROR) {

	    	console.log('검색 결과 중 오류가 발생했습니다.');
	    	return;

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

	$(document).ready(function(){
		$("#addBtn").on("click",function(){
			$("#addForm").submit();
		});
	});//document ready end
	
	</script>
	
	<table>
	<thead>
		<tr>
			<th>지역번호</th>
			<th>지역이름</th>
			<th>마켓이름</th>
		</tr>
	</thead>
	<tbody>
		<c:forEach var="data" items="${list}">
			<tr>
				<td>${data.DISCT_NO}</td>
				<td>${data.DISCT_NAME}</td>
				<td>${data.MARKET_NAME}</td>
			</tr>
		</c:forEach>
	</tbody>	
	</table>
	
<form action="zzanDataAdd" id="addForm" method="post">
주소 <input type="text" id="addr" name="addr" ><br>
위도 <input type="text" id="lat" name="lat" ><br>
경도 <input type="text" id="lng" name="lng" ><br>
</form>
<input type="button" value="저장" id="addBtn">
</body>
</html>