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
	
	// 동적으로 생긴 버튼이라 처리해주는 방법이 다름 
	$("body").on("click", "#richDay_btn", function(){
		$(this).parent().fadeOut(200, function() {
			//$(this).remove();
		});
	});
	
	$("body").on("click", "#savingDay_btn", function(){
		$(this).parent().fadeOut(200, function() {
			//$(this).remove();
		});
	});
	
	//글쓰기 창으로 이동 
	$("#spend_regst").on("click", function(){
		location.href = "accbkC";
	});
	
	$("#most_spend_day").on("click", function(){
		getRichDay();
		$("#richDay_modal").fadeIn(200);
	});
	$("#least_spend_day").on("click", function(){
		getSavingDay();
		$("#savingDay_modal").show();
	});
		//why 안될까욤 
		
	
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

function getRichDay(){
	var today = new Date();
	var richMth = today.getMonth() +1;
	var richY = today.getFullYear();
	var richDay = $("#most_spend_day_num").text();
	
	var ynmnd = richY + "-" + richMth + "-" + richDay;
	
	$.ajax({
		url: "getRichDayAjax", 
		type: "post", 
		dataType: "json", 
		data: {"ynmnd": ynmnd}, 
		success : function(result) {	
			drawRichDay(result.list);
		},
		error: function(request, status, error) { 
			console.log(error);
		}
		
	});
}
function drawRichDay(list){
	var html = "";
	
	for(var data of list){
		html+=	"<a>"+data.ITEMS_NAME +" : " +data.COST+ "</a> ";
		html+= "<br>";
	}
		html+=	"<input type=\"button\" class=\"richDay_btn\"  id=\"richDay_btn\"  value=\"X\" > ";
	$("#richDay_modal").html(html);
}

//savingday 

function getSavingDay(){
	var today = new Date();
	var mth = today.getMonth() +1;
	var savingY = today.getFullYear();
	var sDay = $("#least_spend_day_num").text();
	
	var ynmnd = savingY + "-" + mth + "-" + sDay;
	
	$.ajax({
		url: "getRichDayAjax", 
		type: "post", 
		dataType: "json", 
		data: {"ynmnd": ynmnd}, 
		success : function(result) {	
			drawSavingDay(result.list);
		},
		error: function(request, status, error) { 
			console.log(error);
		}
		
	});

function drawSavingDay(list){
	var html = "";
	
	for(var data of list){
		html+=	"<a>"+data.ITEMS_NAME +" : " +data.COST+ "</a> ";
		html+= "<br>";
	}
		html+=	"<input type=\"button\" class=\"savingDay_btn\"  id=\"savingDay_btn\"  value=\"X\" > ";
	$("#savingDay_modal").html(html);
}
}
</script>
</head>
<body>
<c:import url="/layoutTopLeft"></c:import>
<main>
	 <form action="#" id="go_form" method="post">
      <input type="hidden" id="home_flag" name="home_flag" value="${homeFlag}">
      <input type="hidden" id="menu_idx" name="menu_idx" value="${menuIdx}">
      <input type="hidden" id="sub_menu_idx" name="sub_menu_idx" value="${subMenuIdx}">
   </form>
    <div class="con_contnr">
    	<input type="hidden" id="member_no" name="member_no" value="${sMNo}">
        <div class="con">
			<!--이용자 기간설정 지출금액 나오게  -->
			<div class="accbk_main_notice">
				<h3><span>(닉네임)님</span><br>
				<span id="month_of_today"></span>월 지출 금액은<br>
				<span id="spend_of_month">${getThisMonthSpend.SUM}원</span> 입니다.</h3><br>
				<!--  -->
				<!--css display none으로 설정해주고 그때그때 나오게 해야하나    -->
				<h6> 더 사용 </h6>
				<h6> 덜 사용 </h6>
			</div>
			<!-- 가운데 오게   -->
			
			<input type="button" class="spend_regst" id="spend_regst" value="지출 등록" ><br>
			<div class="accbk_main_summr_contnr" id="accbk_main_summr_contnr">
				<div class="summr_accbk msd" id="most_spend_day">
					<a class="main_summr_title" id="rich_day">가장 많이 쓴 날</a><br>
					<span id="most_spend_day_num">${getMostSpendDay.BUY_DATE}</span> 일<br>
					<span id="most_spend_day_cost">${getMostSpendDay.COST} 원</span>
						<div id="richDay_modal" class="richDay_modal">
						</div>
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
					<span id="least_spend_day_num">${getLeastSpendDay.BUY_DATE}</span> 일<br>
					<span id="least_spend_day_cost">${getLeastSpendDay.COST} 원</span>
					<div id="savingDay_modal" class="savingDay_modal"></div>
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