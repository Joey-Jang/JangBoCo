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
<script type="text/javascript" src="resources/script/layout/default.js"></script>
<script type="text/javascript" src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=9a34fa20b8bdbafa1061701c69f892c1&libraries=services"></script>
<script type="text/javascript" src="resources/script/layout/addrsMapApi.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	// 이전글에 대한 데이터가 없을 시 
	if($("#before_btn").attr("no")==-1){
		$("#before_btn").css({
			"visibility":"hidden"
		})
	};
	// 다음글에 대한 데이터가 없을 시 
	if($("#next_btn").attr("no")==-1){
		$("#next_btn").css({
			"visibility":"hidden"
		})
	};
	// 목록으로 돌아가기
	$("#back_btn").on("click",function(){
		$("#action_form").attr("action","intgrEventList");
		$("#action_form").submit();
	});
	
	// 행사소식 이전글
	$("#before_btn").on("click",function(){
		$("#event_no").val($(this).attr("no"));
		
		$("#action_form").attr("action","intgrEventDtl");
		$("#action_form").submit();
	});
	
	// 행사소식 다음글
	$("#next_btn").on("click",function(){
		$("#event_no").val($(this).attr("no"));
		
		$("#action_form").attr("action","intgrEventDtl");
		$("#action_form").submit();
	});
});
</script>
</head>
<body>
<c:import url="/layoutTopLeft"></c:import>
<main>
	<form action="#" id="go_form" method="post">
      <input type="hidden" id="member_no" name="member_no" value="${memberNo}">
      <input type="hidden" id="home_flag" name="home_flag" value="${homeFlag}">
      <input type="hidden" id="menu_idx" name="menu_idx" value="${menuIdx}">
      <input type="hidden" id="sub_menu_idx" name="sub_menu_idx" value="${subMenuIdx}">
   </form>
    <div class="con_contnr">
        <div class="con">
        	<form action="#" id="action_form" method="post">
        		<input type="hidden" name="searchGbn" value="${param.searchGbn}">
        		<input type="hidden" name="searchText" value="${param.searchText}">
        		<input type="hidden" name="page" value="${param.page}">        		 
        		<input type="hidden" name="eventNo" id="event_no" value="${param.eventNo}">       		
        	</form>
        	<div class="title_back">
        		<button type="button" id="back_btn">뒤로가기</button> 
        		<span>행사소식</span>        		
        	</div>
        	<div class="event_info">
        		<div class="event_title">
        			<span>${data.EVENT_NAME}</span>
        		</div>
        		<div class="write_info">
	        		<span>${data.MARKET_NAME}</span>        		
	        		<span>${data.REGST_DATE}</span>
	        		<div class="market_icon">아이콘이들어갈거임</div>
	        		<span>행사기간: ${data.START_DATE} ~ ${data.END_DATE}</span>
	        		<span>좋아요 ${data.LIKE_CNT}</span>
	        		<span>조회수 ${data.HIT_NUM}</span>
        		</div>
        		<div class="event_con">
        			<span>${data.CON}</span>        			
        		</div>
        		<div class="move_btn">
        			<button type="button" no="${data.EVENT_NO_BEFORE}" id="before_btn">이전글</button>
        			<button type="button" no="${data.EVENT_NO_NEXT}" id="next_btn">다음글</button>        		
        		</div>        		
        	</div>                	 
        </div>
    </div>
    <div class="bottom_contnr"></div>
</main>
</body>
</html>