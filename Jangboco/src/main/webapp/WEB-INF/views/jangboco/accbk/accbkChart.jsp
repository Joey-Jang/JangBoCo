<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>chart</title>
<link rel="preconnect" href="https://fonts.gstatic.com">
<link rel="stylesheet"
	href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100;300;400;500;700;900&display=swap">
<link rel="stylesheet" type="text/css"
	href="resources/css/layout/default.css">
<link rel="stylesheet" href="resources/css/accbk/accbkChart.css"
	type="text/css">
<script type="text/javascript"
	src="resources/script/jquery/jquery-1.12.4.min.js"></script>
<script type="text/javascript" src="resources/script/layout/default.js"></script>
<script type="text/javascript"
	src="https://www.gstatic.com/charts/loader.js"></script>
<script type="text/javascript"
	src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script type="text/javascript"
	src="//dapi.kakao.com/v2/maps/sdk.js?appkey=9a34fa20b8bdbafa1061701c69f892c1&libraries=services"></script>
<script type="text/javascript"
	src="resources/script/layout/addrsMapApi.js"></script>
<script type="text/javascript">
var resultJson ;
$(document).ready(function(){
	
	//주별 지출 금액 차트
	google.charts.load('current',  {'packages':['bar']});
    google.charts.setOnLoadCallback(getSpendChart);
    google.charts.setOnLoadCallback(getMinMaxChart);
	//품목 차트 
	google.charts.load('current', {'packages':['corechart']});
	google.charts.setOnLoadCallback(getAccbkItemsChart);
	
	//지출 min&max 금액 차트
	//google.charts.load('current', {'packages':['bar']});
	
	// 이번 달 표시하기 
	var today = new Date();
	var getMth = today.getMonth() +1;
	var getYear = today.getFullYear().toString();
	var mthStr = getMth.toString();
	
	var getToday = getYear+'-'+mthStr
	
	
	$("#month_of_today").text(getMth);
	$("#mthNYear_of_today").text(getToday);
	
	$("#month_of_today").on("click",function(){
		$("#month_box_contnr").show();
		$("#prev_check_btn").hide();
	});
	$("#prev_cancel_btn").on("click",function(){
		$("#month_box_contnr").hide();
	});
	$("#prev_check_btn").on("click",function(){
		$("#month_box_contnr").hide();
	});
	
	//다시 효과주기 
	/* //sumChart <->minMaxChart 교체
	$("#view_minMax_chart").on("click",function(){
		$("#minMax_chart_contnr").show();
		$("#period_chart_contnr").hide();
		$("#view_minMax_chart").hide();
		$("#view_period_chart").show();
	});
	$("##view_period_chart").on("click",function(){
		$("#minMax_chart_contnr").hide();
		$("#period_chart_contnr").show();
		$("#view_minMax_chart").show();
		$("#view_period_chart").hide();
	}); */
	
	

	
    
    //console.log("is going goooood");
	//날짜 바꿔주기 
	$("#prev_month_btn").on("click",function(){
		if ($("#prev_month_change").val()!=null) {
			$("#month_of_today").text($("#prev_month_change").val());
			$("#mthNYear_of_today").text(getYear+'-'+$("#prev_month_change").val());
		}
		
		getAccbkItemsChart();
		getSpendChart();
		getMinMaxChart();
		$("#prev_cancel_btn").hide();
		$("#prev_check_btn").show();
	});
	
});


	//품목 차트 불러오기 
	function getAccbkItemsChart(){
		var month = $("#mthNYear_of_today").text();
		//console.log("params " + params);
		
		$.ajax({
			url: "accbkItemsChartAjax", 
			type: "post", 
			dataType: "json", 
			data: {"month": month}, 
			success : function(result) {	
				//console.log("result======="+JSON.stringify(result)); //alert(JSON.stringify(data ));
				drawAccbkItemsChart(result);
			},
			error: function(request, status, error) { 
				console.log(error);
			}
			
		});
	}

	//품목 차트 그리기 
	 function drawAccbkItemsChart(result) {
		var iTemsChart  = new google.visualization.DataTable();
		//resultJson = result;
		iTemsChart.addColumn('string','items');
		iTemsChart.addColumn('number','rank');
		
		var data = result.getFiveItems;
		
		for(var i =0; i< data.length; i++){
			iTemsChart.addRow([data[i].ITEMS_NAME, data[i].COST]);
		}
		// Set chart options
		  var options = {'title':'품목 차트',
		                 'width':500,
		                 'height':500,
		                 'pieHole': 0.4,
		                 'slices': {
		                     0: { color: '#038C3E' },
		                     1: { color: '#03A64A' },
		                     2: { color: '#F2C12E' },
		                     3: { color: '#D9B88F' },
		                     4: { color: '#F27405' }
		                   }
		                                 
		};
		  var chart = new google.visualization.PieChart(document.getElementById('items_chart_contnr'));
		  chart.draw(iTemsChart, options);
	}
	
	  //지출 차트 불러오기 	
	function getSpendChart(){
	var month = $("#mthNYear_of_today").text();
	//console.log("params " + params);
	
	$.ajax({
		url: "accbkSpendChartAjax", 
		type: "post", 
		dataType: "json", 
		data: {"month": month}, 
		success : function(result) {	
			drawSpendChart(result);
		},
		error: function(request, status, error) { 
			console.log(error);
		}
		
	});
}
	  
	 //지출 차트 그리기 
	 function drawSpendChart(result){
		 
		var tempList =[];
		var columnData = ['주간', '지출'];
		tempList.push(columnData);
	
		for(var data of result.getSpendSummr) {
			var temp = [data.WEEK, data.COST]	
			tempList.push(temp);
		}

		
	    var data = google.visualization.arrayToDataTable(tempList);

	    var options = {
	      title: '월 차트',
	      bars: 'vertical',
	      vAxis: {format: 'decimal'},
	      width: 400,
	      height: 300,
	      colors: ['#038C3E']
	    };

	    var chart = new google.charts.Bar(document.getElementById('period_chart_contnr'));

	    chart.draw(data, google.charts.Bar.convertOptions(options));
	 }
	 
	//min&max 차트 불러오기 	
	function getMinMaxChart(){
	var month = $("#mthNYear_of_today").text();
	//console.log("params " + params);
	
	$.ajax({
		url: "accbkMinMaxChartAjax", 
		type: "post", 
		dataType: "json", 
		data: {"month": month}, 
		success : function(result) {	
			drawMinMaxChart(result);
		},
		error: function(request, status, error) { 
			console.log(error);
		}
		
	});
}
	  
	 //min&max 차트 그리기 
	 function drawMinMaxChart(result){
		 
		var tempList =[];
		var columnData = ['주간', '최고','최저'];
		tempList.push(columnData);
		for(var data of result.getMinMax){
	  	  var temp = [data.WEEK, data.MAX, data.MIN]
	  	  tempList.push(temp);
	    };
	    
	    var data = google.visualization.arrayToDataTable(tempList);

	    var options = {
	      title: '최고/최저',
	      bars: 'vertical',
	      vAxis: {format: 'decimal'},
	      width: 400,
	      height: 300,
	      colors: ['#038C3E','F2C12E']
	    };

	    var chart = new google.charts.Bar(document.getElementById('minMax_chart_contnr'));

	    chart.draw(data, google.charts.Bar.convertOptions(options));
	 } 
</script>
</head>
<body>
	<c:import url="/layoutTopLeft"></c:import>
	<main>
		<form action="#" id="go_form" method="post">
			<input type="hidden" id="member_no" name="member_no"
				value="${memberNo}"> <input type="hidden" id="home_flag"
				name="home_flag" value="${homeFlag}"> <input type="hidden"
				id="menu_idx" name="menu_idx" value="${menuIdx}"> <input
				type="hidden" id="sub_menu_idx" name="sub_menu_idx"
				value="${subMenuIdx}">
		</form>
		<div class="con_contnr">
			<div class="con">
			<div class="prev_month_contnr">
				<form action="#" id="prev_month_form" method="post">
					<span id="mthNYear_of_today" hidden="" ></span>
					<span id="month_of_today" ></span>
					<a id="month_summr"> 월의 통계</a>
					<div id="month_box_contnr">
						<select id="prev_month_change">
							<option hidden="" selected="selected" disabled="disabled">-이전달-</option>
							<option value="10">10</option>
							<option value="09">09</option>
							<option value="08">08</option>
						</select>
						<input type="button" id="prev_month_btn" value="선택">
						<input type="button" id="prev_cancel_btn" value="취소">
						<input type="button" id="prev_check_btn" value="확인">
					</div>
				</form>
			</div>
				<div id="accbk_chart_contnr">
				<input type="button" id="view_minMax_chart" value="최소/최대값">
				<input type="button" id="view_period_chart" value="sum">
					<div id="chart_div">
						<div id="period_chart_contnr"></div>
						<div id="minMax_chart_contnr"></div>
						<div id="items_chart_contnr"></div>
					</div>
				</div>
			</div>
		</div>
		<div class="bottom_contnr"></div>
	</main>
</body>
</html>