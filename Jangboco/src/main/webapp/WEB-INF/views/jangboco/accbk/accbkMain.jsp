<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>가계부 main</title>
<link rel="preconnect" href="https://fonts.gstatic.com">
<link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100;300;400;500;700;900&display=swap">
<link rel="stylesheet" type="text/css" href="resources/css/layout/default.css">
<link rel="stylesheet" href="resources/css/accbk/accbk.css" type="text/css">
<script type="text/javascript" src="resources/script/jquery/jquery-1.12.4.min.js"></script>
<script type="text/javascript" src="resources/script/layout/default.js"></script>
<script type="text/javascript" src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=9a34fa20b8bdbafa1061701c69f892c1&libraries=services"></script>
<script type="text/javascript" src="resources/script/layout/addrsMapApi.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	// 이번 달 표시하기 
	var today = new Date();
	var getMth = today.getMonth() +1;
	
	$("#month_of_today").text(getMth);
	
	//글쓰기 창으로 이동 
	$("#spend_regst").on("click", function(){
		location.href = "accbkC";
	});
	
});
// 오늘 날짜 ('YYYY-MM-DD')로 바꾸기
function getTodayDate(){
	var today = new Date();
	
	var getY = today.getFullYear();
	var getM = today.getMonth() + 1;
	var getD = today.getDate();
	
	if(getM < 10){
		getM = "0" + getM;
	}
	if(getD < 10){
		getD = "0" + getD;
	}
	
	return getY + "-" + getM + "-" + getD;
	
}

//한 달 전 날짜 구하기 
function getMonthAgo(){
	var today = new Date();
	
	var monthAgoY = today.getFullYear();
	var monthAgoM = today.getMonth() ;
	var monthAgoD = today.getDate();
	
	if(monthAgoM < 10){
		monthAgoM = "0" + monthAgoM;
	}
	if(monthAgoD < 10){
		monthAgoD = "0" + monthAgoD;
	}
	
	return monthAgoY + "-" + monthAgoM + "-" + monthAgoD;
	
} 

// 일년 전 날짜 구하기 
function getYearsAgo(){
	var today = new Date();
	
	var yearsAgoY = today.getFullYear() - 1 ;
	var yearsAgoM = today.getMonth() + 1 ;
	var yearsAgoD = today.getDate();
	
	if(yearsAgoM < 10){
		yearsAgoM = "0" + yearsAgoM;
	}
	if(yearsAgoD < 10){
		yearsAgoD = "0" + yearsAgoD;
	}
	
	return yearsAgoY + "-" + yearsAgoM + "-" + yearsAgoD;
	
} 
// 매달 1일 구하기 
function getMonthFirst(){
	var today = new Date();
	
	var monthFirstY = today.getFullYear();
	var monthFirstM = today.getMonth() + 1 ;
	var monthFirstD = "01";
	
	if(monthFirstM < 10){
		monthFirstM = "0" + monthFirstM;
	}
	
	
	return monthFirstY + "-" + monthFirstM + "-" + monthFirstD;
	
} 

//일주일 전 
function getWeekAgo(){
	var today = new Date();
	var weekAgo = today.getTime() - (7 * 24 * 60 * 60 * 1000);
	today.setTime(weekAgo);
	
	var weekAgoY = today.getFullYear();
	var weekAgoM = today.getMonth() + 1 ;
	var weekAgoD = today.getDate();
	
	if(weekAgoM < 10){
		weekAgoM = "0" + weekAgoM;
	}
	if(weekAgoD < 10){
		weekAgoD = "0" + weekAgoD;
	}
	
	return weekAgoY + "-" + weekAgoM + "-" + weekAgoD;
	
} 

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
			<!--기간 설정 select(오른쪽 끝으로 오게 )-->
			<select id="period_set">
			<option hidden="" disabled="disabled" selected="selected">기간 선택</option>
			<option value="">1주</option>
			<option value="">1개월</option>
			<option value="">1년</option>
			<option value="">직접 입력</option>
			</select>
			<!--이용자 기간설정 지출금액 나오게  -->
			<div class="accbk_main_notice">
				<h3><span>(닉네임)님</span><br>
				<span id="month_of_today"></span>월 지출 금액은<br>
				<span id="spend of month">${getThisMonthSpend.SUM}원</span> 입니다.</h3>
				<!--  -->
				<!--css display none으로 설정해주고 그때그때 나오게 해야하나    -->
				<h6> 더 사용 </h6>
				<h6> 덜 사용 </h6>
			</div>
			<!-- 가운데 오게   -->
			<input type="button" class="spend_regst" id="spend_regst" value="지출 등록" ><br>
			<div class="accbk_main" id="accbk_summr_box">
				<div class="summr_accbk msd" id="most_spend_day">
					<a class="main_summr_title" id="">가장 많이 쓴 날</a><br>
					<span id="most_spend_day_num">${getMostSpendDay.BUY_DATE} 일</span><br>
					<span id="most_spend_day_cost">${getMostSpendDay.COST} 원</span>
					
				</div>
				<div class="summr_accbk msw" id="most_spend_week">
					<a class="main_summr_title">가장 많이 쓴 주</a><br>
					<span id="most_spend_week_num">${getMostSpendWeek.WEEK}번째 주</span><br>
					<span id="most_spend_week_cost">${getMostSpendWeek.COST} 원</span>
				</div>
				<div class="summr_accbk mvm" id="most_visit_market">
					<a class="main_summr_title">단골 마켓</a><br>
					<span id="most_visit_market_name">${getMostVisitMarket.MARKET_NAME}</span><br>
					<span id="most_visit_market_cnt">${getMostVisitMarket.COUNT}회 방문</span>
				</div>
				<br>
				<div class="summr_accbk lsd" id="least_spend_day">
					<a class="main_summr_title">가장 적게 쓴 날</a><br>
					<span id="least_spend_day_num">${getLeastSpendDay.BUY_DATE} 일</span><br>
					<span id="least_spend_day_cost">${getLeastSpendDay.COST} 원</span>
				</div>
				<div class="summr_accbk lsw" id="least_spend_week">
					<a class="main_summr_title">가장 적게 쓴 주</a><br>
					<span id="least_spend_week_num">${getLeastSpendWeek.WEEK}번째 주</span><br>
					<span id="least_spend_week_cost">${getLeastSpendWeek.COST} 원</span>
				</div>
				<div class="summr_accbk msi" id="most_spend_items">
					<a class="main_summr_title">최고 지출 품목</a><br>
					<span id="most_spend_items_item">${getMostSpendItems.ITEMS_NAME}</span><br>
					<span id="most_spend_items_cost">${getMostSpendItems.COST} 원</span>
				</div>
			</div>
        </div>
    </div>
    <div class="bottom_contnr"></div>
</main>
</body>
</html>