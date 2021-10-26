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
<link rel="stylesheet" type="text/css" href="resources/css/join/diary.css">
<script type="text/javascript" src="resources/script/jquery/jquery-1.12.4.min.js"></script>
<script type="text/javascript" src="resources/script/jquery/jquery.form.js"></script>
<script type="text/javascript" src="resources/script/layout/default.js"></script>
<script type="text/javascript" src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=9a34fa20b8bdbafa1061701c69f892c1&libraries=services"></script>
<script type="text/javascript" src="resources/script/layout/addrsMapApi.js"></script>
<script>

</script>
</head>
<body>
<c:import url="/layoutTopLeft"></c:import>
<main>
	<form action="#" id="goForm" method="post">
      	<input type="hidden" name="member_no" value="${memberNo}">
		<input type="hidden" id="home_flag" name="home_flag" value="${param.home_flag}">
		<input type="hidden" id="menu_idx" name="menu_idx" value="${param.menu_idx}">
		<input type="hidden" id="sub_menu_idx" name="sub_menu_idx" value="${param.sub_menu_idx}">
	</form>
    <div class="con_contnr">
        <div class="con">
			<div class="diary_contnr">
				<form action="#" id="actionForm" method="post">
					<input type="hidden" id="no" name="no" />
					<input type="hidden" id="page" name="page" value="${page}" />
					<input type="text" id="searchTxt" name="searchTxt" value="${param.searchTxt}" />
					<input type="hidden" id="oldTxt" value="${param.searchTxt}" />
					<input type="button" id="searchBtn" value="검색" />
					<input type="button" id="addBtn" value="등록" />
				</form>
				<div class="diary_contnr_con">
					<div class="diary_con">
						<div class="nicnm">perola</div>
						<div class="img_url" style="background-image: "></div>
						<div class="like_cnt">2개</div>
						<div class="con">머시기어쩌구저쩌구오버플로우주삼!!!!빨리!!!가나다라마바사</div>	
					</div>
					<div class="diary_con">2</div>
					<div class="diary_con">3</div>
					<div class="diary_con">4</div>
					<div class="diary_con">5</div>
					<div class="diary_con">6</div>
					<div class="diary_con">7</div>
					<div class="diary_con">8</div>
				</div>
				<div id="pagingWrap">
				</div>
	        </div>
	    </div>
    </div>
    <div class="bottom_contnr"></div>
</main>
</body>
</html>