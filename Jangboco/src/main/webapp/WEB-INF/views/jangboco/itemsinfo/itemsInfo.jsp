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
	.paging_wrap {
		display:flex;
		width : 100%;
		height : 30px;
		justify-content: space-between;
		align-items: center;
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
	google.charts.setOnLoadCallback(reloaditemsInfo);
	
	// 지역구별 평균 가격 불러오기
	google.charts.load('current', {'packages':['bar']});
    google.charts.setOnLoadCallback(reloaditemsInfo);
    
    reloadRecipe();
    
    $(".paging_wrap").on("click","span",function(){
		$("#page").val($(this).attr("page"));		
		
		reloadRecipe();
	});
    
    $("tbody").on("click","#go_recipe_dtl",function(){
		$("#rcp_nm").val($(this).attr("nm"));
		
		$("#cook_recipe_form").attr("action","recipeDtl");
		$("#cook_recipe_form").submit();
	});
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
	var params= $("#cook_recipe_form").serialize();
	
	$.ajax({
		url: "recipeAjax", 
		type: "post", 
		dataType: "json", 
		data: params, 
		success : function(res) {			
			drawRecipeList(res);
			drawPaging(res.pb);
		},
		error: function(request, status, error) { 
			console.log(error);
		}
	});
}

function drawRecipeList(res){
	var html = "";
	var pb = res.pb;
	var list = res.recipeList;
	var startCnt = pb.startCount -1;
	var endCnt = pb.endCount -1;	
	
	for(var i = startCnt; i < endCnt; i++ ){
		html += "<tr>               ";
		html += "	<td>"+ list[i].artclNo+ "</td>     ";
		html += "	<td id =\"go_recipe_dtl\" nm = \""+ list[i].RCP_NM + "\">"+ list[i].RCP_NM + "</td>";
		html += "</tr>              ";		
	}
	
	$("tbody").html(html);
	
	
};

function drawPaging(pb){
	var html ="";
	
	html += "<div id=\"first_btn\">    "
	html += "	<span page=\"1\">처음</span>    "
	html += "</div>                  "
	html += "<div>                   "
	if($("#page").val()<=10){		
		html += "	<span page=\"1\">이전</span>    "
	} else {
		html += "	<span page=\"" +(pb.startPcount-1) + "\">이전</span>    "		
	}	
	html += "</div>                  "
	for(var i=pb.startPcount; i<=pb.endPcount; i++){		
		if($("#page").val()==i){
			html += "<div>                   "
			html += "	<span page=\""+ i + "\"><b>"+i+"</b></span>       "
			html += "</div>                  "			
		} else {
			html += "<div>                   "
			html += "	<span page=\""+ i + "\">"+i+"</span>       "
			html += "</div>                  "						
		}
	}
	
	if(pb.endPcount== pb.maxPcount){		
		html += "<div>                   "
		html += "	<span page=\""+pb.maxPcount +"\">다음</span>    "
		html += "</div>                  "
	} else {
		html += "<div>                   "
		html += "	<span page=\""+(pb.endPcount+1) +"\">다음</span>    "
		html += "</div>                  "		
	}
	html += "<div id=\"last_btn\">     "
	html += "	<span page=\""+ pb.maxPcount +"\">마지막</span>  "
	html += "</div>                  "
	
	$(".paging_wrap").html(html);
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
            
            <div class="jangbc_diary_contnr">
            </div>
            
            <div class="cook_recipe_contnr">
            	<form action="#" id="cook_recipe_form" method="post">
            		<input type="hidden" id="matrl_name" name="matrlName" value="${matrlName}">
            		<input type="hidden" id="page" name="page" value="${page}">
            		<input type="hidden" id="rcp_nm" name="rcpNm">
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
            <div class="paging_wrap">        		
        	</div>            
        </div>
    </div>
    <div class="bottom_contnr"></div>
</main>
</body>
</html>