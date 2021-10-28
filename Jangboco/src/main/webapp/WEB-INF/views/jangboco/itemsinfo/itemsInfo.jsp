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
<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	// 선형 차트 불러오기
	google.charts.load('current', {packages: ['corechart', 'line']});
	google.charts.setOnLoadCallback(reloaditemsInfo);
	
	// 지역구별 평균 가격 불러오기
	google.charts.load('current', {'packages':['bar']});
    google.charts.setOnLoadCallback(reloaditemsInfo);
    
    reloadRecipe()
});

function reloaditemsInfo(){
	var params= $("#items_info_form").serialize();
	
	$.ajax({
		url: "itemsInfoAjax", 
		type: "post", 
		dataType: "json", 
		data: params, 
		success : function(res) {			
			drawItemsInfo(res.list);
			drawLineChart(res)
			drawDisctChart(res)
		},
		error: function(request, status, error) { 
			console.log(error);
		}
	});
}

function drawItemsInfo(list){
	var html = ""; 
	
	html += "<span> "+list.ITEMS_NAME+ "["+list.ITEMS_NO+"]</span><br>  ";
	html += "<span> 평균가격"+list.AVG_PRICE+ "원</span><br>";
	
	$(".items_info_con").html(html);	
}

//선형 차트 그리기
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
		for(var d of res.lineChartlist) {
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
					
		}		
	};
	
	var chart = new google.visualization.LineChart(document.getElementById('line_chart_div'));
	chart.draw(data, options);	
} 

// 지역구별 차트 그리기 
function drawDisctChart(res) {
	
	var tempList = [];
	var columnData = ['지역구', '평균', '최고', '최저'];
	tempList.push(columnData);
	for(var data of res.disctChartList){
  	  var temp = [data.DISCT_NAME, data.AVG_PRICE, data.MAX_PRICE, data.MIN_PRICE]
  	  tempList.push(temp);
    };
    
    var data = google.visualization.arrayToDataTable(tempList);

    var options = {      
      bars: 'vertical',
      vAxis: {format: 'decimal'},
      height: 250,
      colors: ['#1b9e77', '#d95f02', '#7570b3']
    };

    var chart = new google.charts.Bar(document.getElementById('disct_chart_div'));

    chart.draw(data, google.charts.Bar.convertOptions(options));
 }
 
function reloadRecipe(){
	var params= $("#matrl_name").val();
	console.log(params);
	$.ajax({
		url: "https://openapi.foodsafetykorea.go.kr/api/121c409444094fdea525/COOKRCP01/json/1/1/RCP_PARTS_DTLS="+ params, 
		type: "post", 
		dataType: "json",		
		success : function(res) {			
			console.log(res);
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
      	<input type="hidden" name="member_no" value="${memberNo}">
		<input type="hidden" id="home_flag" name="home_flag" value="${homeFlag}">
		<input type="hidden" id="menu_idx" name="menu_idx" value="${menuIdx}">
		<input type="hidden" id="sub_menu_idx" name="sub_menu_idx" value="${subMenuIdx}">
	</form>
    <div class="con_contnr">
        <div class="con">
        	<form action="#" id="items_info_form" method="post">
        		<input type="hidden" id="items_no" name="itemsNo" value="${itemsNo}">
        	</form>
            <div class = "items_choice_contnr">
          		<span>육류/돼지고기</span>
            </div>
            <div class="items_info_contnr">
            	<div class="items_img">
            	</div>
            	<div class="items_info_con">            		        		
            	</div>            	
            </div>
            <div id="line_chart_div" style="width: 600px; height: 250px;"></div>
            <div id="disct_chart_div" style="width: 600px; height: 250px;"></div>
            
            <div class="cook_recipe_contnr">
            	<form action="#" id="cook_recipe_form" method="post">
            		<input type="hidden" id="matrl_name" name="matrlName" value="${matrlName}">
            	</form>
            	<p>요리레시피</p>
            	<table class="cook_recipe_table">
            		<thead>
            			<tr>
            				<td>#</td>
            				<td>레시피</td>
            			</tr>
            		</thead>
            		<tbody>
            		</tbody>
            	</table>
            </div>
            <div class="jangbc_diary_contnr">
            </div>
        </div>
    </div>
    <div class="bottom_contnr"></div>
</main>
</body>
</html>