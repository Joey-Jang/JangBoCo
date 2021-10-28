<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>chart</title>
<link rel="preconnect" href="https://fonts.gstatic.com">
<link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100;300;400;500;700;900&display=swap">
<link rel="stylesheet" type="text/css" href="resources/css/layout/default.css">
<link rel="stylesheet" href="resources/css/accbk/accbk.css" type="text/css">
<script type="text/javascript" src="resources/script/jquery/jquery-1.12.4.min.js"></script>
<script type="text/javascript" src="resources/script/layout/default.js"></script>
<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
<script type="text/javascript" src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=9a34fa20b8bdbafa1061701c69f892c1&libraries=services"></script>
<script type="text/javascript" src="resources/script/layout/addrsMapApi.js"></script>
<script type="text/javascript">
	// Load the Visualization API and the corechart package.
	google.charts.load('current', {'packages':['corechart']});
	
	// Set a callback to run when the Google Visualization API is loaded.
	google.charts.setOnLoadCallback(drawChart);
	
	// Callback that creates and populates a data table,
	// instantiates the pie chart, passes in the data and
	// draws it.
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
			<!--Div that will hold the pie chart-->
		    <div id="chart_div"></div>
        </div>
    </div>
    <div class="bottom_contnr"></div>
</main>
</body>
</html>