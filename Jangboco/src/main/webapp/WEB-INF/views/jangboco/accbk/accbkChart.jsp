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
<link rel="stylesheet" href="resources/css/accbk/accbk.css"
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
	// 이번 달 표시하기 
	var today = new Date();
	var getMth = today.getMonth() +1;
	
	$("#month_of_today").text(getMth);
	
	
	// Load the Visualization API and the corechart package.
	google.charts.load('current', {'packages':['corechart']});
	
	// Set a callback to run when the Google Visualization API is loaded.
	google.charts.setOnLoadCallback(drawChart);
	
	google.charts.load('current', {'packages':['corechart']});
	
	google.charts.setOnLoadCallback(getAccbkItemsChart);
	
	// Callback that creates and populates a data table,
	// instantiates the pie chart, passes in the data and
	// draws it.
	/* google.charts.load('current', {'packages':['corechart']});
    google.charts.setOnLoadCallback(drawPeriodChart); */
    
    //console.log("is going goooood");
	
});


	function getAccbkItemsChart(){
		var month = $("#month_of_today").text();
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


	function drawChart() {
	
		  // Create the data table.
		  var data = new google.visualization.DataTable();
		  data.addColumn('string', 'Topping');
		  data.addColumn('number', 'Slices');
		  data.addRows([
		    ['Mushrooms', 3],
		    ['Onions', 1],
		    ['Olives', 1],
		    ['Zucchini', 1],
		    ['Pepperoni', 2]
		  ]);
		
		  // Set chart options
		  var options = {'title':'이걸 과연 바꿀 수 있을까 ',
		                 'width':400,
		                 'height':300};
		
		  // Instantiate and draw our chart, passing in some options.
		  var chart = new google.visualization.PieChart(document.getElementById('chart_div'));
		  chart.draw(data, options);
	}
	
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
		                     0: { color: '#03A64A' },
		                     1: { color: '#F2C12E' },
		                     2: { color: '#038C3E' },
		                     3: { color: '#D9B88F' },
		                     4: { color: '#F27405' }
		                   }
		                                 
		};
		  var chart = new google.visualization.PieChart(document.getElementById('period_chart_contnr'));
		  chart.draw(iTemsChart, options);
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
				<div id="accbk_chart_contnr">
					<span id="month_of_today"></span>
					<div id="chart_div"></div>
					<div id="period_chart_contnr"></div>
				</div>
			</div>
		</div>
		<div class="bottom_contnr"></div>
	</main>
</body>
</html>