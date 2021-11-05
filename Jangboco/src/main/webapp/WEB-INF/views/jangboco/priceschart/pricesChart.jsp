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
<style type="text/css">
	.chart_contnr {
		display: flex;
		flex-flow: row wrap;
		justify-content: space-between;
		align-content: space-between;
		align-items: center;
		height: 100%;
	}
	
	/* 지역구별 차트 */
	#line_chart_items_choice {
		display: none;
		position: absolute;
		z-index:1000;
		background-color: #dff4e8;
		border-radius: 10px;
		width:350px;
	    padding: 10px;
        top: 30px;
    	right: 32px;
	}
	
	#chkbox_list ul {
		list-style-type: none;
		padding-inline-start: 0;
	}
	.line_chart_items_form_contnr,#chkbox_list,#chkbox_result {
		background-color: #FFFFFF;
		border-radius: 5px;
	}	
	
	.line_choice_btn_contnr{		
		margin-top: 5px;
		display: flex;
    	justify-content: center;
	}
	.line_choice_btn,#line_chart_btn{
	    border: 1px solid;
	    background-color: #03A64A;
	    cursor: pointer;
	    border-radius: 5px;
	    color: #FFFFFF;
	}
	
	#line_chart_btn{
		position: absolute;
		z-index: 999;
		top: 10px;
    	right: 10px;
	}
	
	.chart_div{
		width: 100%;
		height: 100%;
	}
	
	.line_chart_contnr{
		position: relative;
		padding: 15px;
		border: 15px solid #03A64A20;
    	border-radius: 20px;
    	
    	width: 100%;
    	height: 50%;
	}
	
	/* 지역구별 차트 */
	.disct_chart_items_choice{
		display: none;
		position: absolute;
		z-index:1000;
		background-color: #dff4e8;	    
	    max-width: 540px;
	    border-radius: 10px;
	    padding: 10px;
        bottom: 10px;
	    right: 10px;	    
	}
	
	.disct_chart_items_choice_background{
		background-color: #FFFFFF;
	    height: 40px;
	    max-width: 540px;
	    border-radius: 10px;
	    padding: 7px;
	    text-align: center;
	}
	
	#disct_items_choice_form , .disct_choice_btn_contnr{
		display: inline-block;
	}
	
	#disct_items_choice_form,#disct_items_choice,#disct_choice_success_btn,#disct_choice_cancel_btn{
		margin-right: 5px;
	}
	
	#disct_chart_btn,.disct_choice_btn{		
	    border: 1px solid;
	    background-color: #03A64A;
	    cursor: pointer;
	    border-radius: 5px;
	    color: #FFFFFF;
	}
	#disct_chart_btn{
		position: absolute;
		z-index: 999;
		bottom: 10px;
	    right: 10px;
	}
	
	.disct_chart_contnr{
		position: relative;
		padding: 20px 15px 10px 15px;
		border: 15px solid #03A64A20;
    	border-radius: 20px;
    	/* margin-top: 15px; */
    	/* height: 350px; */
    	
    	width: 45%;
    	height: 45%;
	}
	
	/* 카테고리 차트  */	
	.category_chart_choice{
		display: none;
		position: absolute;
		z-index:1000;
		background-color: #dff4e8;	    
	    max-width: 540px;
	    border-radius: 10px;
	    padding: 10px;
        bottom: 10px;
	    right: 10px;	    
	}
	
	.category_chart_choice_background{
		background-color: #FFFFFF;
	    height: 40px;
	    max-width: 540px;
	    border-radius: 10px;
	    padding: 7px;
	    text-align: center;
	}
	
	#category_items_choice_form , .category_choice_btn_contnr{
		display: inline-block;
	}
	
	/* #disct_items_choice_form,#disct_items_choice,#disct_choice_success_btn,#disct_choice_cancel_btn{
		margin-right: 5px;
	}
	 */
	#category_chart_btn,.category_choice_btn{		
	    border: 1px solid;
	    background-color: #03A64A;
	    cursor: pointer;
	    border-radius: 5px;
	    color: #FFFFFF;
	}
	#category_chart_btn{
		position: absolute;
		z-index: 999;
		bottom: 10px;
	    right: 10px;
	}
	
	.category_chart_contnr{
		position: relative;
		padding: 0 15px 30px 15px;
		border: 15px solid #03A64A20;
    	border-radius: 20px;
    	/* margin-top: 15px; */
    	/* height: 350px; */
    	
    	width: 45%;
    	height: 45%;
	}
</style>
<script type="text/javascript" src="resources/script/jquery/jquery-1.12.4.min.js"></script>
<script type="text/javascript" src="resources/script/layout/default.js"></script>
<script type="text/javascript" src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=9a34fa20b8bdbafa1061701c69f892c1&libraries=services"></script>
<script type="text/javascript" src="resources/script/layout/addrsMapApi.js"></script>
<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	// 선형 차트 불러오기
	google.charts.load('current', {packages: ['corechart', 'line']});
	google.charts.setOnLoadCallback(getLineChartData);
	
	// 지역구별 평균 가격 불러오기
	google.charts.load('current', {'packages':['bar']});
    google.charts.setOnLoadCallback(getDisctChartData);
	
    // 대분류별 차트 불러오기
    google.charts.load('current', {packages: ['corechart', 'bar']});
    google.charts.setOnLoadCallback(getCategoryChartData);
    
    
    
	$("#line_chart_btn").on("click",function(){
		$("#line_chart_items_choice").show();
	});
	
	// 선형 차트 품목 선택 시 체크박스리스트 아작스 호출
	$("#line_items_name").on("change", function(){
		getLineItemsChoice();
	});
	
	// 체크박스 체크 시 #chkbox_result에 span 그려주기 위한 이벤트
	$("#chkbox_list").on("change",".items_list_chkbox",function(){
		$(this).each(function(){
			if($(this).is(":checked")){
				
				var html = "";
				html += "<span class=\"items_chkbox\" value="+$(this).val()+">"+$(this).next().html()+" </span>";
				
				$("#chkbox_result").append(html);				
			} else {
				$(".items_chkbox[value='" + $(this).val() + "']").remove();
			}			
		});
		
	});
	
	// 선형 차트 품목 선택 완료 시 ajax함수 호출
	$("#line_choice_success_btn").on("click",function(){
		$("#line_chart_items_choice").hide();
		getLineChartData();
	});
	
	// 선형 차트 품목 선택 취소 시 초기화
	$("#line_choice_cancel_btn").on("click",function(){
		$("#chkbox_list").html('');
		$("#chkbox_result").html('');
		$("#start_date").val('');
		$("#line_items_name").val($("#hidden_value").val());
		$("#line_chart_items_choice").hide();
	});
	
	
	
	$("#disct_chart_btn").on("click",function(){
		$(".disct_chart_items_choice").show();
	});
	
	// 지역구 차트 품목선택시 세부목록 출력할 ajax함수 호출
	$("#disct_items_name").on("change", function(){
		getDisctItemsChoice();
	});
	
	// 지역구 차트 품목선택 완료 버튼 클릭 이벤트
	$("#disct_choice_success_btn").on("click", function(){
		$("#disct_items_no").val($("#disct_items_choice").val());
		$(".disct_chart_items_choice").hide();
		getDisctChartData();
	});
	
	// 지역구 차트 품목선택 취소 버튼 클릭 이벤트
	$("#disct_choice_cancel_btn").on("click",function(){
		var html = "<option hidden=\"\" disabled=\"disabled\" selected=\"selected\" value=\"\">세부선택</option>"
		$("#disct_items_choice").html(html);
		$("#disct_items_name").val($("#hidden_value").val());
		$(".disct_chart_items_choice").hide();
		
	});	
	
	
	$("#category_chart_btn").on("click",function(){
		$(".category_chart_choice").show();
	});
	
	$("#category_choice_success_btn").on("click",function(){
		getCategoryChartData();
		$(".category_chart_choice").hide();
	});
	
	$("#category_choice_cancel_btn").on("click",function(){		
		$("#category_choice").val('0');
		$(".category_chart_choice").hide();
	});
});

// 다중선택한 품목을 배열변수에 담아서 넘기기 위한 함수
function lineChartChk() {

	var itemsNo = Array();	
	
	$(".items_chkbox").each(function() {
		itemsNo.push($(this).attr("value"));
	});
	
	// 기간 설정 값을 넘기기 위한 변수 처리
	var startDate = $("#start_date").val();
	
	var endDate = $("#end_date").val();	
	
	
	$("#start_date_value").val(convertDate(startDate));
	$("#end_date_value").val(convertDate(endDate));	
	$("#line_items_no").val(itemsNo);
	
	// default값
	if($("#line_items_no").val() != null && $("#line_items_no").val() == ''){
		$("#line_items_no").val('99');
	}
}

// 날짜 변환 함수
function convertDate(date){
	var d= date;
	
	var yy = d.substr(2,2);
	
	var mm = d.substr(5,2);
	
	var dd = d.substr(8,2);
	
	return yy + '-' + mm + '-' + dd;
}

// 선형차트 체크박스 목록 ajax 
function getLineItemsChoice(){
	var params = $("#line_items_choice_form").serialize();
	$.ajax({
		url: "lineItemsChoiceAjax", 
		type: "post", 
		dataType: "json",
		data: params,		
		success : function(res) {			
			drawChkboxList(res.list)
		},
		error: function(request, status, error) { 
			console.log(error);
		}
	});
}

// 체크박스목록 그리기
function drawChkboxList(list){
	var html = "";
		html += "<ul>";
	for(var data of list) {
		
		html += "<li><input type=\"checkbox\" class=\"items_list_chkbox\" value="+data.ITEMS_NO+">";
		html += "<span>품목번호: "+data.ITEMS_NO +" 품목이름: " +data.ITEMS_NAME +"</span></li>"		;
	}
		html += "</ul>";
	$("#chkbox_list").html(html);
	
	$(".items_chkbox").each(function() {
		$(".items_list_chkbox[value='" + $(this).attr("value") + "']").prop("checked", true);
	});
}

// 데이터 및 선형 차트 그리기 위한 ajax
function getLineChartData(){	
	lineChartChk();
	var params = $("#line_chart_form").serialize();
	$.ajax({
		url: "lineChartAjax", 
		type: "post", 
		dataType: "json",
		data: params,		
		success : function(res) {			
			drawLineChart(res)
		},
		error: function(request, status, error) { 
			console.log(error);
		}
	});
}

// 차트그리기
function drawLineChart(res) {
	var data = new google.visualization.DataTable();	
	
	data.addColumn('string','일자');
	for(var item of res.itemNameList) {
		data.addColumn('number', item.ITEMS_NAME +'['+item.ITEMS_NO +']');
	}
	
	var tempList = [];
	
	var tempDt = res.dateList[0];
	
	var cFlag = false;
	
	for(var dt of res.dateList) {
		var temp = [dt];
		for(var d of res.list) {
			if(dt == d.UPDATE_DATE) {
				temp.push(d.AVG_PRICE);
			} else {
				cFlag = true;
			}
		}
		tempList.push(temp);
	}
	
	if(!cFlag) {
		tempList.push(temp);
	}

	data.addRows(tempList);
		
	var options = {		
		hAxis: {
						
		},
		vAxis: {
					
		},
		colors: ['#03A64A','#F2C12E','#038C3E','#D9B88F','#F27405']
	};
	
	var chart = new google.visualization.LineChart(document.getElementById('chart_div'));
	chart.draw(data, options);	
} 

// 지역구 차트 품목선택 그리기 위한 ajax
function getDisctItemsChoice(){
	var params = $("#disct_items_choice_form").serialize();
	$.ajax({
		url: "disctItemsChoiceAjax", 
		type: "post", 
		dataType: "json",
		data: params,		
		success : function(res) {			
			drawItemsList(res.list)
		},
		error: function(request, status, error) { 
			console.log(error);
		}
	});
}

// 품목선택 그리기 함수
function drawItemsList(list){
	var html = "";
	
	html += "<option hidden=\"\" disabled=\"disabled\" selected=\"selected\" value=\"\">세부선택</option> ";
	for(var data of list){
		html += "<option value="+data.ITEMS_NO +">"+"품목번호: "+data.ITEMS_NO +" 품목이름: " +data.ITEMS_NAME +"</option>                                                 "		
	}
	
	$("#disct_items_choice").html(html);
}

// 지역구 차트 데이터 호출 및 차트출력 ajax
function getDisctChartData(){
	var params = $("#disct_chart_form").serialize();
	$.ajax({
		url: "disctChartAjax", 
		type: "post", 
		dataType: "json",
		data: params,		
		success : function(res) {			
			drawDisctChart(res)
		},
		error: function(request, status, error) { 
			console.log(error);
		}
	});
	
}

// 차트 그리기 
function drawDisctChart(res) {
	
	var tempList = [];
	var columnData = ['지역구', '평균', '최고', '최저'];
	tempList.push(columnData);
	for(var data of res.list){
  	  var temp = [data.DISCT_NAME, data.AVG_PRICE, data.MAX_PRICE, data.MIN_PRICE]
  	  tempList.push(temp);
    };
    
    var data = google.visualization.arrayToDataTable(tempList);

    var options = {      
      bars: 'vertical',
      vAxis: {format: 'decimal'},   
      /* height: 300, */
      colors: ['#03A64A', '#F2C12E', '#F27405']
    };

    var chart = new google.charts.Bar(document.getElementById('disct_chart_div'));

    chart.draw(data, google.charts.Bar.convertOptions(options));
  }
  
// 카테고리 차트 데이터 호출 및 그리기
function getCategoryChartData(){
	var choiceResult = [];
	if($("#category_choice").val() == "0") {
		choiceResult = [];		
	} else if($("#category_choice").val() == "1"){
		choiceResult = ['달걀','닭고기','돼지고기','쇠고기'];
	} else if($("#category_choice").val() == "2"){
		choiceResult = ['갈치','고등어','냉동참조기','동태','명태','오징어','조기'];
	} else {
		choiceResult = ['무','배','배추','사과','상추','애호박','양파','오이','호박'];
	}
	$("#category_items_name").val(choiceResult);
	
	var params = $("#category_chart_form").serialize();
	$.ajax({
		url: "categoryChartAjax", 
		type: "post", 
		dataType: "json",
		data: params,		
		success : function(res) {			
			drawCategoryChart(res)
		},
		error: function(request, status, error) { 
			console.log(error);
		}
	});
}


function drawCategoryChart(res) {
	var tempList = [];
	var columnData = ['품목', '평균가격'];
	tempList.push(columnData);
	for(var data of res.list){
		var temp = [data.ITEMS_NAME+'['+data.ITEMS_NO+']',data.AVG_PRICE]
		tempList.push(temp);
	}
    var data = google.visualization.arrayToDataTable(tempList);
		
    var options = {     
      chartArea: {width: '50%'},
      hAxis: {        
        minValue: 0
      },
      /* height:300, */
      vAxis: {
        
      },
      colors:['#03A64A']
    };

    var chart = new google.visualization.BarChart(document.getElementById('category_chart_div'));

    chart.draw(data, options);
  }
  
function getLatestVarncData(){
	var params = $("#disct_chart_form").serialize();
	$.ajax({
		url: "disctChartAjax", 
		type: "post", 
		dataType: "json",
		data: params,		
		success : function(res) {			
			drawDisctChart(res)
		},
		error: function(request, status, error) { 
			console.log(error);
		}
	});	
}
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
        	<div class="chart_contnr">
        		<form action="#" id="line_chart_form" method="post">
        			<input type="hidden" id="start_date_value" name="startDate">
        			<input type="hidden" id="end_date_value" name="endDate">   			        			
        			<input type="hidden" id="line_items_no" name="itemsNo">        			
        		</form>
        		<div class="line_chart_contnr">
	       			<button type="button" id="line_chart_btn">선택</button>
	        		<div id="line_chart_items_choice">
	        			<div class="line_chart_items_form_contnr">
		        			<form action="#" id="line_items_choice_form" method="post">
		        				<input type="date" id="start_date">
		        				<input type="date" id="end_date"><br>        			
			        			<select id="line_items_name" name="itemsName">
			        				<option hidden="" disabled="disabled" selected="selected" value="">품목선택</option>
			        				<option value="갈치">갈치</option>
			        				<option value="고등어">고등어</option>
			        				<option value="달걀">달걀</option>
			        				<option value="닭고기">닭고기</option>
			        				<option value="동태">동태</option>
			        				<option value="돼지고기">돼지고기</option>
			        				<option value="명태">명태</option>
			        				<option value="무">무</option>
			        				<option value="배">배</option>
			        				<option value="배추">배추</option>
			        				<option value="사과">사과</option>
			        				<option value="상추">상추</option>
			        				<option value="쇠고기">쇠고기</option>
			        				<option value="애호박">애호박</option>
			        				<option value="양파">양파</option>
			        				<option value="오이">오이</option>
			        				<option value="오징어">오징어</option>
			        				<option value="조기">조기</option>
			        				<option value="호박">호박</option>
			        			</select>
		        			</form>
	        			</div>
	        			<div id="chkbox_list">	        				
	        			</div>
	        			<div id="chkbox_result">	        				
	        			</div>
	        			<div class="line_choice_btn_contnr">
		        			<button type="button" class="line_choice_btn" id="line_choice_success_btn">확인</button>
		        			<button type="button" class="line_choice_btn" id="line_choice_cancel_btn">취소</button>			        				     				
	        			</div>
	        		</div>
	        		<div class="chart_div" id="chart_div"></div>
        		</div>
        		
        		<form action="#" id="disct_chart_form" method="post">
        			<input type="hidden" id="disct_items_no" name="itemsNo" value="99">        			
        		</form>
        		<div class="disct_chart_contnr">
	        		<button type="button" id="disct_chart_btn">품목선택</button>
	        		<div class="disct_chart_items_choice">
	        			<div class="disct_chart_items_choice_background">
		        			<form action="#" id="disct_items_choice_form" method="post">
			        			<select id="disct_items_name" name="itemsName">
			        				<option id="hidden_value" hidden="" disabled="disabled" selected="selected" value="">품목선택</option>
			        				<option value="갈치">갈치</option>
			        				<option value="고등어">고등어</option>
			        				<option value="달걀">달걀</option>
			        				<option value="닭고기">닭고기</option>
			        				<option value="동태">동태</option>
			        				<option value="돼지고기">돼지고기</option>
			        				<option value="명태">명태</option>
			        				<option value="무">무</option>
			        				<option value="배">배</option>
			        				<option value="배추">배추</option>
			        				<option value="사과">사과</option>
			        				<option value="상추">상추</option>
			        				<option value="쇠고기">쇠고기</option>
			        				<option value="애호박">애호박</option>
			        				<option value="양파">양파</option>
			        				<option value="오이">오이</option>
			        				<option value="오징어">오징어</option>
			        				<option value="조기">조기</option>
			        				<option value="호박">호박</option>
			        			</select>        				     				
		        			</form>
		        			<select id="disct_items_choice"> 
		        				<option hidden="" disabled="disabled" selected="selected" value="">세부선택</option>        				      			 
		        			</select>
			        		<div class="disct_choice_btn_contnr">
			        			<button type="button" class="disct_choice_btn" id="disct_choice_success_btn">확인</button>
			        			<button type="button" class="disct_choice_btn" id="disct_choice_cancel_btn">취소</button>
			        		</div>
	        			</div>
	        		</div>        		
	        		<div class="chart_div" id="disct_chart_div"></div>
        		</div>
        		
        		<form action="#" id="category_chart_form" method="post">
        			<input type="hidden" id="category_items_name" name="itemsName" value="">        			
        		</form>
        		<div class="category_chart_contnr">
	        		<button type="button" id="category_chart_btn">품목선택</button>
	        		<div class="category_chart_choice">
	        			<div class="category_chart_choice_background">
			        		<select id="category_choice"> 
			        			<option value="0">전체</option>
			        			<option value="1">육류</option>        			
				        		<option value="2">수산</option>
				        		<option value="3">과일/채소</option>        				      			 
			        		</select>
			        		<div class="category_choice_btn_contnr">
								<button type="button" class="category_choice_btn" id="category_choice_success_btn">확인</button>
				        		<button type="button" class="category_choice_btn" id="category_choice_cancel_btn">취소</button>
			        		</div>
	        			</div>
	        		</div>
	        		<div class="chart_div" id="category_chart_div"></div>        		
        		</div>
        		       	
        	</div>
        </div>
    </div>
    <div class="bottom_contnr"></div>
</main>
</body>
</html>