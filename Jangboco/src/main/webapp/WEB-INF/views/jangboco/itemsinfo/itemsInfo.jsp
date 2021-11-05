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
	main {
	    min-width: 1110px;
	    min-height: 660px;
	}
	
	.items_info_title_contnr{
		margin-left: 20px;
		margin-bottom: 20px;
	}
	
	.items_choice_popup{
		display: none;
		position: absolute;
		z-index:1000;
		background-color: #dff4e8;	    
	    max-width: 540px;
	    border-radius: 10px;
	    padding: 10px;
	}
	
	.items_choice_popup_background{
		background-color: #FFFFFF;
	    height: 40px;
	    max-width: 540px;
	    border-radius: 10px;
	    padding: 7px;
	    text-align: center;
	}
	
	#items_choice_dtl , #items_choice_form{
		display: inline-block;
	}
	
	#items_info_title{
		font-size: 30px;
		margin-bottom: 10px;		
	}
	
	#items_info_title:hover{
		cursor: pointer;
		border-bottom:2.5px solid #03A64A; 
		padding-bottom:3px;
		/* text-decoration: underline;
		text-decoration-color: #03A64A; */
		width : 100%;
	}
	
	.items_info_flex_contnr {
		display: flex;
		flex-direction: row;
		margin:15px;
	    align-items: center;
	    justify-content: center;
	    padding-bottom: 10px;
	    border-bottom: 2px solid #C4C4C4;
	}
	
	.items_info_contnr{
		display: flex;
		flex-direction: row;
	}
	
	.items_img {
		width: 200px;
		height:200px;
		border: 1px solid #C4C4C4;
		margin-right: 35px;				
	}
	
	#items_img{
		width:100%;
		height:100%;
	}
	
	.items_info_con{
		font-size: 35px;
		padding: 10px;
		margin-right: 35px;		
	}		

	
	.line_chart_contnr{		
		background-color: #03A64A20;
		padding: 25px;
    	border-radius: 20px;
    	margin-right: 50px;
    	width:25%
	}
	
	.disct_chart_contnr{		
		background-color: #03A64A20;
		padding: 25px;
    	border-radius: 20px;
    	width:25%
	}
	
	
	/* 다이어리 */
	.jangbc_diary_contnr{
  		position: relative;
  		margin: auto;		
	}
	
	.jangbc_diary_slides{
		display: flex;
		width: 1500px;
    	margin: auto;
    	display: none;
	}
	
	.jangbc_diary_data_contnr{
		border: 1px solid black;
		width:300px;
		height: 250px;
	}
	
	.full-img {
		width: 100%;
		height: 100%;
		object-fit: cover;
	}
	
	.card-wrapper {
	  width: 100%;
	  display: flex;
	  flex-wrap: wrap;
	  height: calc(100% - 90px);
	}
	.card {
	  width: 25%;
	  height: 50%;
	  padding: 15px;
	  background: white;
	}
	.card-header {
	  height: 40px;
	  margin-bottom: 5px;
	  padding: 0 10px;
	  display: flex;
	  justify-content: space-between;
	  align-items: center;
	}
	.card-user {
	  display: flex;
	  align-items: center;
	}
	.card-user-profile {
	  width: 32px;
	  height: 32px;
	  border-radius: 20px;
	  overflow: hidden;
	}
	.card-like {
	  display: flex;
	  align-items: end;
	}
	.card-like img {
	  width: 25px;
	}
	.card-like span {
	  display: block;
	  margin-left: 5px;
	}
	.card-user-name {
	  margin-left: 5px;
	  font-weight: bold;
	}
	.card-thumbnail {
	  position: relative;
	  width: 100%;
	  height: 70%;
	  overflow: hidden;
	  border-radius: 10px;
	}
	.card-thumbnail-views {
	  position: absolute;
	  right: 10px;
	  bottom: 10px;
	  font-size: 14px;
	  opacity: 0.8;
	  color: #fff;
	}
	.card-contents {
	  margin-top: 10px;
	  padding: 0 10px;
	  line-height: 1.2;
	  height: 20px;
	  overflow: hidden;
	}
	
	/* Next & previous buttons */
	.prev, .next {
	  cursor: pointer;
	  position: absolute;
	  top: 50%;
	  width: auto;
	  margin-top: -22px;
	  padding: 16px;
	  color: #03A64A;
	  font-weight: bold;
	  font-size: 18px;
	  transition: 0.6s ease;
	  border-radius: 3px 0 0 3px;
	  user-select: none;
	}
	.prev {
		left:346px;
	}
	.next {
		right:346px;
	}
	/* Position the "next button" to the right */
	.next {
	  right:346px;
	  border-radius: 0 3px 3px 0;
	}
	
	/* On hover, add a black background color with a little bit see-through */
	.prev:hover, .next:hover {
	  background-color: #03A64A;
	  color:#FFFFFF;
	}
	
	
	/* 요리 레시피 */
	.recipe_title {
		text-align: center;
		font-size: 20px;
	}
	table{
		width: 2000px;
		min-height:250px;
		text-align: center;
		border-collapse: collapse;
		table-layout:fixed;
		margin: auto;		
	}
	
	thead{
		border-bottom: 2px solid #000000;	
	}	
	
	tbody{
		height:220px;
	}
	
	tbody tr{		
		border-bottom: 1px solid #D9B88F;
		height:2vh;
	}
	.recipe_no{
		width:30%;
	}
	.recipe_name {
		text-overflow:ellipsis;
		overflow:hidden;
		white-space: nowrap;		
	}
	
	tbody .recipe_name:hover{
		cursor:pointer;
	}
	
	.paging_wrap {
		display:flex;
		width : auto;
		/* height : 30px; */
		 justify-content: center;
		/* align-items: center;  */
		margin: auto;
		margin-top: 20px;
	}
	
	.paging_btn {
		width: 50px;
		padding-top: 10px;
		padding-bottom: 10px;
		text-align:center;
		border: 1px solid #C4C4C4;
		border-left:0;
	}
	
	.paging_btn:hover{
		background-color: #03A64A20;
		cursor: pointer;
	}
	
	#first_btn {
		border-left:1px solid #C4C4C4;
	}
	
	.recipe_modal{
		display: none;
		background: #dff4e8;
		border-radius: 20px;
    	z-index: 3;
    	position: absolute;
	    width: 2305px;
	    height: 1261px;
	    font-family: 'Noto Sans KR', sans-serif;
	    font-size: 11pt;
	    font-weight: 400;
	}
	
	.recipe_contnr{
		width: 680px;
	    background-color: #FFFFFF;
	    padding: 10px;
	    border-radius: 10px;
	    position: relative;
	    margin: auto;
	    top: 20%;
	}
	
	.recipe_title{
		font-size: 35px;
	    margin-bottom: 10px;
	    display: block;
	    text-align: center;
	}
	
	.recipe_info_contnr{
	    display: flex;
	    flex-direction: row;
	    padding: 15px;
	    border: 1px solid #03A64A;
	    border-radius: 10px;
	}
	
	.recipe_info_img_contnr{
		width: 200px;
    	height: 200px;
	}
	
	#recipe_img{
		width: 100%;
	    height: 100%;
	}
	
	.recipe_nuttn_info_contnr{
		width: auto;
	    padding: 15px;
	    font-size: 16px;
	}
	
	.recipe_matrl_contnr{
		width: 275px;
	}
	.recipe_matrl{
		display: block;
   		text-align: center;
	}
	.recipe_manual_contnr {
		display: flex;
	    flex-direction: row;
	    flex-wrap: wrap;
	    width: 100%;
	    border: 1px solid #03A64A;
	    border-radius: 10px;
	    margin-top: 10px;		
	}
	
	.recipe_manaul_img_con_contnr{
	    display: flex;
	    width: 50%;
	    padding: 5px;
	}
	
	.recipe_manual_img{
	    width: 119px;
    	height: 80px;
	}
	.manual_img {
		width: 119px;
	    height: 80px;
	    border-radius: 10px;
	}
	.recipe_manual{
		width: 100%;
	    height: 80px;
	    overflow: auto;
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
    
    $("#items_info_title").on("click",function(){
		$(".items_choice_popup").show();
	});
    
    $("#category_choice").on("change", function(){
    	getItemsChoice();
	});
    
    $("#items_choice_dtl").on("change", function(){
    	console.log($("#items_choice_dtl").val());
    	$("#items_no").val($("#items_choice_dtl").val());
    	$(".items_choice_popup").hide();
    	reloaditemsInfo();
	});
    
    $(".paging_wrap").on("click","span",function(){
		$("#page").val($(this).attr("page"));		
		
		reloadRecipe();
	});
    
    $("tbody").on("click","#go_recipe_dtl",function(){
		$("#recipe_no").val($(this).attr("no"));		
		reloadRecipeDtl();
		$(".recipe_modal").show();
	});
    
    $(".recipe_modal").on("click",function(){
    	$(".recipe_modal").hide();    	   	
    });
    
    $(window).resize(function(){
    	reloaditemsInfo();		
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
			drawLineChart(res);
			drawDisctChart(res);
			$("#matrl_name").val(res.matrlName);
			$(".items_img").html("<img id=\"items_img\" src=\"resources/images/itemsInfo/"+res.matrlName+"_outlined.png\" onerror=\"this.src='resources/images/itemsInfo/noimg.png'\">")
			$("#items_info_title").text(res.matrlName + " ▼ ");
			console.log("레시피리로드 실행")
			reloadRecipe();
			
		},
		error: function(request, status, error) { 
			console.log(error);
		}
	});
}

function drawItemsInfo(list){
	var html = ""; 
	
	html += "<span>"+list.ITEMS_NAME+ "[ 품목번호: "+list.ITEMS_NO+"]</span><br><br>  ";
	html += "<span> 평균가격: "+list.AVG_PRICE+ "원</span><br>";
	
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
		height:250,
		vAxis: {
					
		},
		colors:['#03A64A']
	};
	
	var chart = new google.visualization.LineChart(document.getElementById('line_chart_div'));
	chart.draw(data, options);	
	window.addEventListener('resize', drawLineChart, false);
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
      colors: ['#03A64A', '#F2C12E', '#F27405']
    };

    var chart = new google.charts.Bar(document.getElementById('disct_chart_div'));

    chart.draw(data, google.charts.Bar.convertOptions(options));
    window.addEventListener('resize', drawLineChart, false);
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
			console.log("레시피리로드 성공")
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
	
	for(var i = startCnt; i <= endCnt; i++ ){
		html += "<tr>               ";
		html += "	<td>"+ list[i].artclNo+ "</td>     ";
		html += "	<td class=\"recipe_name\" id =\"go_recipe_dtl\" no = \""+ list[i].RCP_SEQ + "\">"+ list[i].RCP_NM + "</td>";
		html += "</tr>              ";		
	}
	
	$("tbody").html(html);
	
	
};

function drawPaging(pb){
	var html ="";
	
	html += "<div class=\"paging_btn\" id=\"first_btn\">    "
	html += "	<span page=\"1\">처음</span>    "
	html += "</div>                  "
	html += "<div class=\"paging_btn\" >                   "
	if($("#page").val()<=10){		
		html += "	<span page=\"1\">이전</span>    "
	} else {
		html += "	<span page=\"" +(pb.startPcount-1) + "\">이전</span>    "		
	}	
	html += "</div>                  "
	for(var i=pb.startPcount; i<=pb.endPcount; i++){		
		if($("#page").val()==i){
			html += "<div class=\"paging_btn\" >                   "
			html += "	<span page=\""+ i + "\"><b>"+i+"</b></span>       "
			html += "</div>                  "			
		} else {
			html += "<div class=\"paging_btn\" >                   "
			html += "	<span page=\""+ i + "\">"+i+"</span>       "
			html += "</div>                  "						
		}
	}
	
	if(pb.endPcount== pb.maxPcount){		
		html += "<div class=\"paging_btn\" >                   "
		html += "	<span page=\""+pb.maxPcount +"\">다음</span>    "
		html += "</div>                  "
	} else {
		html += "<div class=\"paging_btn\" >                   "
		html += "	<span page=\""+(pb.endPcount+1) +"\">다음</span>    "
		html += "</div>                  "		
	}
	html += "<div class=\"paging_btn\" id=\"last_btn\">     "
	html += "	<span page=\""+ pb.maxPcount +"\">마지막</span>  "
	html += "</div>                  "
	
	$(".paging_wrap").html(html);
}

function getItemsChoice(){
	var choiceResult = [];
	if($("#category_choice").val() == "1"){
		choiceResult = ['달걀','닭고기','돼지고기','쇠고기'];
	} else if($("#category_choice").val() == "2"){
		choiceResult = ['갈치','고등어','냉동참조기','동태','명태','오징어','조기'];
	} else {
		choiceResult = ['무','배','배추','사과','상추','애호박','양파','오이','호박'];
	}	
	
	$.ajax({
		url: "itemsChoiceAjax", 
		type: "post", 
		dataType: "json", 
		data: "itemsName=" + choiceResult, 
		success : function(res) {		
			drawItemsChoiceDtl(res.list)
		},
		error: function(request, status, error) { 
			console.log(error);
		}
	});
}

function drawItemsChoiceDtl(list){
	var html = "";
	html += "<option hidden=\"\" disabled=\"disabled\" selected=\"selected\" value=\"\">세부선택</option>";
	
	for(var data of list){
	html += "<option value="+data.ITEMS_NO+">품목번호: "+ data.ITEMS_NO +" , 품목명: "+ data.ITEMS_NAME +"</option>";		
	}
	
	$("#items_choice_dtl").html(html);
}

function reloadRecipeDtl(){	
	var params = $("#cook_recipe_form").serialize();
	
	$.ajax({
		url: "recipeDtlAjax", 
		type: "post", 
		dataType: "json", 
		data: params, 
		success : function(res) {			
			drawRecipeDtl(res.recipe);
		},
		error: function(request, status, error) { 
			console.log(error);
		}
	});
}

function drawRecipeDtl(data){
	var html = "";		
	
	html += "<span class=\"recipe_title\">"+ data.RECIPE_NAME +"</span>                           ";
	html += "<div class=\"recipe_info_contnr\">                                      ";
	html += "	<div class=\"recipe_info_img_contnr\">                               ";
	html += "		<img id=\"recipe_img\" alt=\"\" src=\""+ data.ATT_FILE_MAIN +"\" onerror=\"this.src='resources/images/itemsInfo/noimg.png'\">               ";
	html += "	</div>	        		                                           ";
	html += "	<div class=\"recipe_nuttn_info_contnr\">                             ";
	html += "		<span>조리방법: "+ data.RECIPE_WAY2 +"</span><br>                         ";
	html += "		<span>요리종류: "+ data.RECIPE_PAT2 +"</span><br>                         ";
	html += "		<span>열량: "+ data.INFO_ENG +"</span><br>	        				       ";
	html += "		<span>탄수화물: "+ data.INFO_CAR +"</span><br>	        				   ";
	html += "		<span>단백질: "+ data.INFO_PRO +"</span><br>	        				   ";
	html += "		<span>지방: "+ data.INFO_FAT +"</span><br>	        				       ";
	html += "		<span>나트륨: "+ data.INFO_NA +"</span><br>	        				   ";
	html += "	</div>	        		                                           ";
	html += "	<div class=\"recipe_matrl_contnr\">";
	html += "		<span class=\"recipe_matrl\">재료정보</span>";
	html += "		<span>"+ data.RECIPE_PARTS_DTLS +"</span>";
	html += "	</div>    ";
	html += "</div>                                                                ";
	html += "<div class=\"recipe_manual_contnr\">                                    ";
	if(data.MANUAL1 != null && data.MANUAL1 !=''){
		html += "	<div class=\"recipe_manaul_img_con_contnr\">                         ";
		html += "		<div class=\"recipe_manual_img\">                                ";
		html += "			<img class=\"manual_img\" src=\""+ data.MANUAL_IMG1 +"\" onerror=\"this.src='resources/images/itemsInfo/noimg.png'\">                           ";
		html += "		</div>                                                         ";
		html += "		<div class=\"recipe_manual\">                                    ";
		html += "			<span>"+ data.MANUAL1 +"</span>                                        ";
		html += "		</div>                                                         ";
		html += "	</div>	        		                                           ";
	}
	if(data.MANUAL2 != null && data.MANUAL2 !=''){
		html += "	<div class=\"recipe_manaul_img_con_contnr\">                         ";
		html += "		<div class=\"recipe_manual_img\">                                ";
		html += "			<img class=\"manual_img\" src=\""+ data.MANUAL_IMG2 +"\" onerror=\"this.src='resources/images/itemsInfo/noimg.png'\">                           ";
		html += "		</div>                                                         ";
		html += "		<div class=\"recipe_manual\">                                    ";
		html += "			<span>"+ data.MANUAL2 +"</span>                                        ";
		html += "		</div>                                                         ";
		html += "	</div>	        		                                           ";
	}
	if(data.MANUAL3 != null && data.MANUAL3 !=''){
		html += "	<div class=\"recipe_manaul_img_con_contnr\">                         ";
		html += "		<div class=\"recipe_manual_img\">                                ";
		html += "			<img class=\"manual_img\" src=\""+ data.MANUAL_IMG3 +"\" onerror=\"this.src='resources/images/itemsInfo/noimg.png'\">                           ";
		html += "		</div>                                                         ";
		html += "		<div class=\"recipe_manual\">                                    ";
		html += "			<span>"+ data.MANUAL3 +"</span>                                        ";
		html += "		</div>                                                         ";
		html += "	</div>	        		                                           ";
	}
	if(data.MANUAL4 != null && data.MANUAL4 !=''){
		html += "	<div class=\"recipe_manaul_img_con_contnr\">                         ";
		html += "		<div class=\"recipe_manual_img\">                                ";
		html += "			<img class=\"manual_img\" src=\""+ data.MANUAL_IMG4 +"\" onerror=\"this.src='resources/images/itemsInfo/noimg.png'\">                           ";
		html += "		</div>                                                         ";
		html += "		<div class=\"recipe_manual\">                                    ";
		html += "			<span>"+ data.MANUAL4 +"</span>                                        ";
		html += "		</div>                                                         ";
		html += "	</div>	        		                                           ";
	}
	if(data.MANUAL5 != null && data.MANUAL5 !=''){
		html += "	<div class=\"recipe_manaul_img_con_contnr\">                         ";
		html += "		<div class=\"recipe_manual_img\">                                ";
		html += "			<img class=\"manual_img\" src=\""+ data.MANUAL_IMG5 +"\" onerror=\"this.src='resources/images/itemsInfo/noimg.png'\">                           ";
		html += "		</div>                                                         ";
		html += "		<div class=\"recipe_manual\">                                    ";
		html += "			<span>"+ data.MANUAL5 +"</span>                                        ";
		html += "		</div>                                                         ";
		html += "	</div>	        		                                           ";
	}
	if(data.MANUAL6 != null && data.MANUAL6 !=''){
		html += "	<div class=\"recipe_manaul_img_con_contnr\">                         ";
		html += "		<div class=\"recipe_manual_img\">                                ";
		html += "			<img class=\"manual_img\" src=\""+ data.MANUAL_IMG6 +"\" onerror=\"this.src='resources/images/itemsInfo/noimg.png'\">                           ";
		html += "		</div>                                                         ";
		html += "		<div class=\"recipe_manual\">                                    ";
		html += "			<span>"+ data.MANUAL6 +"</span>                                        ";
		html += "		</div>                                                         ";
		html += "	</div>	        		                                           ";
	}
	if(data.MANUAL7 != null && data.MANUAL7 !=''){
		html += "	<div class=\"recipe_manaul_img_con_contnr\">                         ";
		html += "		<div class=\"recipe_manual_img\">                                ";
		html += "			<img class=\"manual_img\" src=\""+ data.MANUAL_IMG7 +"\" onerror=\"this.src='resources/images/itemsInfo/noimg.png'\">                           ";
		html += "		</div>                                                         ";
		html += "		<div class=\"recipe_manual\">                                    ";
		html += "			<span>"+ data.MANUAL7 +"</span>                                        ";
		html += "		</div>                                                         ";
		html += "	</div>	        		                                           ";
	}
	if(data.MANUAL8 != null && data.MANUAL8 !=''){
		html += "	<div class=\"recipe_manaul_img_con_contnr\">                         ";
		html += "		<div class=\"recipe_manual_img\">                                ";
		html += "			<img class=\"manual_img\" src=\""+ data.MANUAL_IMG8 +"\" onerror=\"this.src='resources/images/itemsInfo/noimg.png'\">                           ";
		html += "		</div>                                                         ";
		html += "		<div class=\"recipe_manual\">                                    ";
		html += "			<span>"+ data.MANUAL8 +"</span>                                        ";
		html += "		</div>                                                         ";
		html += "	</div>	        		                                           ";
	}
	if(data.MANUAL9 != null && data.MANUAL9 !=''){
		html += "	<div class=\"recipe_manaul_img_con_contnr\">                         ";
		html += "		<div class=\"recipe_manual_img\">                                ";
		html += "			<img class=\"manual_img\" src=\""+ data.MANUAL_IMG9 +"\" onerror=\"this.src='resources/images/itemsInfo/noimg.png'\">                           ";
		html += "		</div>                                                         ";
		html += "		<div class=\"recipe_manual\">                                    ";
		html += "			<span>"+ data.MANUAL9 +"</span>                                        ";
		html += "		</div>                                                         ";
		html += "	</div>	        		                                           ";
	}
	if(data.MANUAL10 != null && data.MANUAL10 !=''){
		html += "	<div class=\"recipe_manaul_img_con_contnr\">                         ";
		html += "		<div class=\"recipe_manual_img\">                                ";
		html += "			<img class=\"manual_img\" src=\""+ data.MANUAL_IMG10 +"\" onerror=\"this.src='resources/images/itemsInfo/noimg.png'\">                           ";
		html += "		</div>                                                         ";
		html += "		<div class=\"recipe_manual\">                                    ";
		html += "			<span>"+ data.MANUAL10 +"</span>                                        ";
		html += "		</div>                                                         ";
		html += "	</div>	        		                                           ";
	}
	if(data.MANUAL11 != null && data.MANUAL11 !=''){
		html += "	<div class=\"recipe_manaul_img_con_contnr\">                         ";
		html += "		<div class=\"recipe_manual_img\">                                ";
		html += "			<img class=\"manual_img\" src=\""+ data.MANUAL_IMG11 +"\" onerror=\"this.src='resources/images/itemsInfo/noimg.png'\">                           ";
		html += "		</div>                                                         ";
		html += "		<div class=\"recipe_manual\">                                    ";
		html += "			<span>"+ data.MANUAL11 +"</span>                                        ";
		html += "		</div>                                                         ";
		html += "	</div>	        		                                           ";
	}
	if(data.MANUAL12 != null && data.MANUAL12 !=''){
		html += "	<div class=\"recipe_manaul_img_con_contnr\">                         ";
		html += "		<div class=\"recipe_manual_img\">                                ";
		html += "			<img class=\"manual_img\" src=\""+ data.MANUAL_IMG12 +"\" onerror=\"this.src='resources/images/itemsInfo/noimg.png'\">                           ";
		html += "		</div>                                                         ";
		html += "		<div class=\"recipe_manual\">                                    ";
		html += "			<span>"+ data.MANUAL12 +"</span>                                        ";
		html += "		</div>                                                         ";
		html += "	</div>	        		                                           ";
	}
	if(data.MANUAL13 != null && data.MANUAL13 !=''){
		html += "	<div class=\"recipe_manaul_img_con_contnr\">                         ";
		html += "		<div class=\"recipe_manual_img\">                                ";
		html += "			<img class=\"manual_img\" src=\""+ data.MANUAL_IMG13 +"\" onerror=\"this.src='resources/images/itemsInfo/noimg.png'\">                           ";
		html += "		</div>                                                         ";
		html += "		<div class=\"recipe_manual\">                                    ";
		html += "			<span>"+ data.MANUAL13 +"</span>                                        ";
		html += "		</div>                                                         ";
		html += "	</div>	        		                                           ";
	}
	if(data.MANUAL14 != null && data.MANUAL14 !=''){
		html += "	<div class=\"recipe_manaul_img_con_contnr\">                         ";
		html += "		<div class=\"recipe_manual_img\">                                ";
		html += "			<img class=\"manual_img\" src=\""+ data.MANUAL_IMG14 +"\" onerror=\"this.src='resources/images/itemsInfo/noimg.png'\">                           ";
		html += "		</div>                                                         ";
		html += "		<div class=\"recipe_manual\">                                    ";
		html += "			<span>"+ data.MANUAL14 +"</span>                                        ";
		html += "		</div>                                                         ";
		html += "	</div>	        		                                           ";
	}
	if(data.MANUAL15 != null && data.MANUAL15 !=''){
		html += "	<div class=\"recipe_manaul_img_con_contnr\">                         ";
		html += "		<div class=\"recipe_manual_img\">                                ";
		html += "			<img class=\"manual_img\" src=\""+ data.MANUAL_IMG15 +"\" onerror=\"this.src='resources/images/itemsInfo/noimg.png'\">                           ";
		html += "		</div>                                                         ";
		html += "		<div class=\"recipe_manual\">                                    ";
		html += "			<span>"+ data.MANUAL15 +"</span>                                        ";
		html += "		</div>                                                         ";
		html += "	</div>	        		                                           ";
	}
	if(data.MANUAL16 != null && data.MANUAL16 !=''){
		html += "	<div class=\"recipe_manaul_img_con_contnr\">                         ";
		html += "		<div class=\"recipe_manual_img\">                                ";
		html += "			<img class=\"manual_img\" src=\""+ data.MANUAL_IMG16 +"\" onerror=\"this.src='resources/images/itemsInfo/noimg.png'\">                           ";
		html += "		</div>                                                         ";
		html += "		<div class=\"recipe_manual\">                                    ";
		html += "			<span>"+ data.MANUAL16 +"</span>                                        ";
		html += "		</div>                                                         ";
		html += "	</div>	        		                                           ";
	}
	if(data.MANUAL17 != null && data.MANUAL17 !=''){
		html += "	<div class=\"recipe_manaul_img_con_contnr\">                         ";
		html += "		<div class=\"recipe_manual_img\">                                ";
		html += "			<img class=\"manual_img\" src=\""+ data.MANUAL_IMG17 +"\" onerror=\"this.src='resources/images/itemsInfo/noimg.png'\">                           ";
		html += "		</div>                                                         ";
		html += "		<div class=\"recipe_manual\">                                    ";
		html += "			<span>"+ data.MANUAL17 +"</span>                                        ";
		html += "		</div>                                                         ";
		html += "	</div>	        		                                           ";
	}
	if(data.MANUAL18 != null && data.MANUAL18 !=''){
		html += "	<div class=\"recipe_manaul_img_con_contnr\">                         ";
		html += "		<div class=\"recipe_manual_img\">                                ";
		html += "			<img class=\"manual_img\" src=\""+ data.MANUAL_IMG18 +"\" onerror=\"this.src='resources/images/itemsInfo/noimg.png'\">                           ";
		html += "		</div>                                                         ";
		html += "		<div class=\"recipe_manual\">                                    ";
		html += "			<span>"+ data.MANUAL18 +"</span>                                        ";
		html += "		</div>                                                         ";
		html += "	</div>	        		                                           ";
	}
	if(data.MANUAL19 != null && data.MANUAL19 !=''){
		html += "	<div class=\"recipe_manaul_img_con_contnr\">                         ";
		html += "		<div class=\"recipe_manual_img\">                                ";
		html += "			<img class=\"manual_img\" src=\""+ data.MANUAL_IMG19 +"\" onerror=\"this.src='resources/images/itemsInfo/noimg.png'\">                           ";
		html += "		</div>                                                         ";
		html += "		<div class=\"recipe_manual\">                                    ";
		html += "			<span>"+ data.MANUAL19 +"</span>                                        ";
		html += "		</div>                                                         ";
		html += "	</div>	        		                                           ";
	}
	if(data.MANUAL20 != null && data.MANUAL20 !=''){
		html += "	<div class=\"recipe_manaul_img_con_contnr\">                         ";
		html += "		<div class=\"recipe_manual_img\">                                ";
		html += "			<img class=\"manual_img\" src=\""+ data.MANUAL_IMG20 +"\" onerror=\"this.src='resources/images/itemsInfo/noimg.png'\">                           ";
		html += "		</div>                                                         ";
		html += "		<div class=\"recipe_manual\">                                    ";
		html += "			<span>"+ data.MANUAL20 +"</span>                                        ";
		html += "		</div>                                                         ";
		html += "	</div>	        		                                           ";
	}	
	html += "</div>                                                                ";		
	$(".recipe_contnr").html(html);
}

function reloadJangbcList(){
		
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
   	<div class="recipe_modal">
	   	<div class="recipe_contnr">	        	
	    </div>
	</div>
    <div class="con_contnr">    	
        <div class="con">
        	<form action="#" id="items_info_form" method="post">
        		<input type="hidden" id="items_no" name="itemsNo" value="${itemsNo}">
        	</form>
            <div class = "items_choice_contnr">
            	<div class="items_info_title_contnr">
	          		<span id="items_info_title">돼지고기 ▼ </span>
	          		<div class="items_choice_popup">
	          			<div class="items_choice_popup_background">
		          			<form action="#" id="items_choice_form" method="post">
			          			<select class="category_choice" id="category_choice" name="categoryChoice">
			          				<option id="hidden_value" hidden="" disabled="disabled" selected="selected" value="">대분류선택</option>
			          				<option value="1">육류</option>        			
					        		<option value="2">수산</option>
					        		<option value="3">과일/채소</option>
			          			</select>
		          			</form>
		          			<select id="items_choice_dtl"> 
		        				<option hidden="" disabled="disabled" selected="selected" value="">세부선택</option>        				      			 
		        			</select>
	          			</div>
	          		</div>
            	</div>
            </div>
            <div class="items_info_flex_contnr">
	            <div class="items_info_contnr">
	            	<div class="items_img">	            		
	            	</div>
	            	<div class="items_info_con">            		        		
	            	</div>            	
	            </div>
	            <div class="line_chart_contnr">
		            <div id="line_chart_div"></div>
	            </div>
	            <div class="disct_chart_contnr">
		            <div id="disct_chart_div"></div>
	            </div>
            </div>             
            
            <div class="jangbc_diary_contnr">
            	<div class="jangbc_diary_slides">
            		<div class="card-wrapper">
	            		<div class="card">            		
	            			<div class="card-header">
	            				<div class="card-user">
	            					<div class="card-user-profile">
	            						<img class="full-img" alt="프로필" src="resources/images/diaryImages/profile.png">
	            					</div>
	            					<p class="card-user-name">닉네임</p>
	            				</div>
	            				<div class="card-like">
	            					<img alt="좋아요" src="resources/images/diaryImages/heart.png">
	            					<span>0</span>
	            				</div>
	            			</div>
	            			<div class="card-thumbnail">
	            				<span class="card-thumbnail-views">조회수...</span>
	            				<img class="full-img" src="resources/images/diaryImages/1.jpg">            				
	            			</div>
	            			<div class="card-contetns">다이어리 내용</div>
	            		</div>
	            		<div class="card">            		
	            			<div class="card-header">
	            				<div class="card-user">
	            					<div class="card-user-profile">
	            						<img class="full-img" alt="프로필" src="resources/images/diaryImages/profile.png">
	            					</div>
	            					<p class="card-user-name">닉네임</p>
	            				</div>
	            				<div class="card-like">
	            					<img alt="좋아요" src="resources/images/diaryImages/heart.png">
	            					<span>0</span>
	            				</div>
	            			</div>
	            			<div class="card-thumbnail">
	            				<span class="card-thumbnail-views">조회수...</span>
	            				<img class="full-img" src="resources/images/diaryImages/1.jpg">            				
	            			</div>
	            			<div class="card-contetns">다이어리 내용</div>
	            		</div>
	            		<div class="card">            		
	            			<div class="card-header">
	            				<div class="card-user">
	            					<div class="card-user-profile">
	            						<img class="full-img" alt="프로필" src="resources/images/diaryImages/profile.png">
	            					</div>
	            					<p class="card-user-name">닉네임</p>
	            				</div>
	            				<div class="card-like">
	            					<img alt="좋아요" src="resources/images/diaryImages/heart.png">
	            					<span>0</span>
	            				</div>
	            			</div>
	            			<div class="card-thumbnail">
	            				<span class="card-thumbnail-views">조회수...</span>
	            				<img class="full-img" src="resources/images/diaryImages/1.jpg">            				
	            			</div>
	            			<div class="card-contetns">다이어리 내용</div>
	            		</div>
	            		<div class="card">            		
	            			<div class="card-header">
	            				<div class="card-user">
	            					<div class="card-user-profile">
	            						<img class="full-img" alt="프로필" src="resources/images/diaryImages/profile.png">
	            					</div>
	            					<p class="card-user-name">닉네임</p>
	            				</div>
	            				<div class="card-like">
	            					<img alt="좋아요" src="resources/images/diaryImages/heart.png">
	            					<span>0</span>
	            				</div>
	            			</div>
	            			<div class="card-thumbnail">
	            				<span class="card-thumbnail-views">조회수...</span>
	            				<img class="full-img" src="resources/images/diaryImages/1.jpg">            				
	            			</div>
	            			<div class="card-contetns">다이어리 내용</div>
	            		</div>
              		</div>
            	</div>
            	<form action="#" id="jangbc_diary_tag_form" method="post">
            		<input type="hidden" name="" id="" value=""> 
            	</form>
            	<div class="jangbc_diary_slides">
            		<div class="card-wrapper">
	            		<div class="card">            		
	            			<div class="card-header">
	            				<div class="card-user">
	            					<div class="card-user-profile">
	            						<img class="full-img" alt="프로필" src="resources/images/diaryImages/profile.png">
	            					</div>
	            					<p class="card-user-name">닉네임</p>
	            				</div>
	            				<div class="card-like">
	            					<img alt="좋아요" src="resources/images/diaryImages/heart.png">
	            					<span>0</span>
	            				</div>
	            			</div>
	            			<div class="card-thumbnail">
	            				<span class="card-thumbnail-views">조회수...</span>
	            				<img class="full-img" src="resources/images/diaryImages/1.jpg">            				
	            			</div>
	            			<div class="card-contetns">다이어리 내용</div>
	            		</div>
	            		<div class="card">            		
	            			<div class="card-header">
	            				<div class="card-user">
	            					<div class="card-user-profile">
	            						<img class="full-img" alt="프로필" src="resources/images/diaryImages/profile.png">
	            					</div>
	            					<p class="card-user-name">닉네임</p>
	            				</div>
	            				<div class="card-like">
	            					<img alt="좋아요" src="resources/images/diaryImages/heart.png">
	            					<span>0</span>
	            				</div>
	            			</div>
	            			<div class="card-thumbnail">
	            				<span class="card-thumbnail-views">조회수...</span>
	            				<img class="full-img" src="resources/images/diaryImages/1.jpg">            				
	            			</div>
	            			<div class="card-contetns">다이어리 내용</div>
	            		</div>
	            		<div class="card">            		
	            			<div class="card-header">
	            				<div class="card-user">
	            					<div class="card-user-profile">
	            						<img class="full-img" alt="프로필" src="resources/images/diaryImages/profile.png">
	            					</div>
	            					<p class="card-user-name">닉네임</p>
	            				</div>
	            				<div class="card-like">
	            					<img alt="좋아요" src="resources/images/diaryImages/heart.png">
	            					<span>0</span>
	            				</div>
	            			</div>
	            			<div class="card-thumbnail">
	            				<span class="card-thumbnail-views">조회수...</span>
	            				<img class="full-img" src="resources/images/diaryImages/1.jpg">            				
	            			</div>
	            			<div class="card-contetns">다이어리 내용</div>
	            		</div>
	            		<div class="card">            		
	            			<div class="card-header">
	            				<div class="card-user">
	            					<div class="card-user-profile">
	            						<img class="full-img" alt="프로필" src="resources/images/diaryImages/profile.png">
	            					</div>
	            					<p class="card-user-name">닉네임</p>
	            				</div>
	            				<div class="card-like">
	            					<img alt="좋아요" src="resources/images/diaryImages/heart.png">
	            					<span>0</span>
	            				</div>
	            			</div>
	            			<div class="card-thumbnail">
	            				<span class="card-thumbnail-views">조회수...</span>
	            				<img class="full-img" src="resources/images/diaryImages/1.jpg">            				
	            			</div>
	            			<div class="card-contetns">다이어리 내용</div>
	            		</div>
              		</div>  			
            	</div>
            	<a class="prev" onclick="plusSlides(-1)">&#10094;</a>
  				<a class="next" onclick="plusSlides(1)">&#10095;</a>
            </div>
            <script type="text/javascript">
            var slideIndex = 1;
            showSlides(slideIndex);

            // Next/previous controls
            function plusSlides(n) {
              showSlides(slideIndex += n);
            }

            // Thumbnail image controls
            function currentSlide(n) {
              showSlides(slideIndex = n);
            }

            function showSlides(n) {
              var i;
              var slides = document.getElementsByClassName("jangbc_diary_slides");
              
              if (n > slides.length) {slideIndex = 1}
              if (n < 1) {slideIndex = slides.length}
              for (i = 0; i < slides.length; i++) {
                  slides[i].style.display = "none";
              }
              
              slides[slideIndex-1].style.display = "block";
              
            }
            </script>
            <div class="cook_recipe_contnr">
            	<form action="#" id="cook_recipe_form" method="post">
            		<input type="hidden" id="matrl_name" name="matrlName" value="${matrlName}">
            		<input type="hidden" id="page" name="page" value="${page}">
            		<input type="hidden" id="recipe_no" name="recipeNo">
            	</form>
            	<p class="recipe_title">요리레시피</p>
            	<table class="cook_recipe_table">
            		<thead>
            			<tr>
            				<td class="recipe_no">#</td>
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