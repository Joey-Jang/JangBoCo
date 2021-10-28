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
	.market_info{
		display: flex;
		flex-direction: row;
	}
	.market_img {
		border: 1px solid silver;
		width: 200px;
		height:150px;
	}

	.items_list{
		display: flex;		
		flex-wrap: wrap;
		width: 400px;
		height:auto;
	}
	.item_row {
		display: flex;
		flex-direction: row;
		width: 50%
	
	}
	.item_img{
		border: 1px solid silver;
		width : 100px;
		height: 60px;
	}
	.item_info{
		border: 1px solid silver;
		width : 100px;
		height: 60px;
	}
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
<script type="text/javascript">
$(document).ready(function(){
	if("${param.searchGbn}" != ""){
		$("#search_gbn").val("${param.searchGbn}");
	}
	if("${marketMemberNo}" != ""){
		if(timeCheck("${marketInfo.START_TIME}","${marketInfo.END_TIME}")){
			$("#time_check").html("영업 중");
			$("#time_check").css("color","green");
		} else {
			$("#time_check").html("영업 종료");	
			$("#time_check").css("color","red");
		}		
	}
	
	reloadItemsList()
	reloadEventList();
	
	$(".paging_wrap").on("click","span",function(){
		$("#page").val($(this).attr("page"));
		$("#search_text").val($("#save_text").val());
		
		reloadEventList();
	});
	
	$("#search_btn").on("click",function(){
		$("#save_text").val($("#search_text").val());
		$("#page").val("1");
		
		reloadEventList();
	});
	
	$("#search_text").on("keypress",function(event){
		if(event.keyCode == 13){
			$("#search_btn").click();
			return false;
		}
	});
		
});

function timeCheck(startTime,endTime){
	var now= new Date();
	var hours = now.getHours();
	var minutes = now.getMinutes();
	var nowTime = hours.toString() + minutes;
	
	startTime = startTime.replace(":", "");
	endTime = endTime.replace(":", "");
	
	if(nowTime>startTime && nowTime<endTime){
		return true;
	} else {
		return false;
	}
	 
	
}

function reloadItemsList(){
	var params = $("#items_form").serialize();
	
	$.ajax({
		url: "marketItemsListAjax", 
		type: "post", 
		dataType: "json", 
		data: params, 
		success : function(res) {			
			drawItemsList(res.list);
			
		},
		error: function(request, status, error) { 
			console.log(error);
		}
	});
}

function drawItemsList(list){
	var html ="";
	
	for(var data of list){		
		html += "<div class=\"item_row\">            "
		html += "	<div class=\"item_img\"></div>   "
		html += "	<div class=\"item_info\">        "
		html += "		<span>"+data.ITEMS_NAME +"</span>        "
		html += "		<span>"+data.PRICE +"</span>        "
		html += "		<span>"+data.NOTE +"</span>        "
		      			            			
		html += "	</div>                         "
		html += "</div>                            "
	}
	
	$(".items_list").html(html);	
}

function reloadEventList(){
	var params = $("#action_form").serialize();
	
	$.ajax({ 
		url: "marketInfoEventAjax", 
		type: "post", 
		dataType: "json", 
		data: params, 
		success : function(res) {			
			drawEventList(res.list);
			drawPaging(res.pb);
		},
		error: function(request, status, error) { 
			console.log(error);
		}
	});
};



// 행사소식 출력
function drawEventList(list){
	var html = "";
	
	
	for( var data of list){		
		html += "<tr>        ";
		html += "    <td>"+ data.EVENT_NO +"</td>                   ";
		html += "    <td  no=\""+data.EVENT_NO +"\" id=\"go_event_dtl\">";
		html +=		 data.EVENT_NAME;
		html +=	"	 </td>	";
		html += "    <td>"+ data.REGST_DATE +"</td>            ";
		html += "    <td>"+ data.START_DATE +"</td>            ";
		html += "    <td>"+ data.END_DATE +"</td>            ";
		html += "    <td>"+ data.LIKE_CNT +"</td>                  ";
		html += "    <td>"+ data.HIT_NUM +"</td>                 ";
		html += "</tr>                            "		;
	}
	
	$(".event_list").html(html);	
}

//페이징 출력
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
            <div class="market_dtl_title">우리동네 가격 비교</div>
            <div class="market_info">
            	<div class="market_img"></div>
            	<div class="market_info_con">
            		<c:choose>
            			<c:when test="${!empty marketMemberNo}">
			            	<span>${marketInfo.MARKET_NAME}</span><br>
			            	<span>${marketInfo.ADDRS} ${marketInfo.DTL_ADDRS}</span><br>
			            	<span>${marketInfo.PHONE_NUM}</span><br>
			            	<span>${marketInfo.START_TIME} - ${marketInfo.END_TIME}</span><br>
			            	<span id="time_check"></span>			            	
            			</c:when>
            			<c:otherwise>
            				<span>${marketInfo.MARKET_NAME}</span>
            			</c:otherwise>
            		</c:choose>
            	</div>
            </div>
           	<form action="#" id="items_form" method="post">
           		<input type="hidden" name="marketNo" value="${marketNo}">
           		<input type="hidden" name="itemsChoiceNo" value="${itemsChoiceNo}">
           	</form>
            <div class="items_list">
            	<div class="item_row">
            		<div class="item_img"></div>
            		<div class="item_info">
            			<span>품목명</span>
            			<span>재고여부</span>
            			<span>가격</span>
            			<span>지역평균</span>            			            			
            		</div>
            	</div>            	
            </div>
            <div class="event_list_wrap">
            	<span>마켓명 행사 소식</span>
	            <table>
	                <thead>
	                    <tr>
	                        <th>#</th>
	                        <th>행사제목</th>
	                        <th>등록일</th>
	                        <th>시작</th>
	                        <th>종료</th>
	                        <th>♥</th>
	                        <th>조회수</th>
	                    </tr>
	                </thead>
	                <tbody class="event_list">	            	
	            	</tbody>
	            </table>
        	</div>
        	<div class="search_form">
           		<form action="#" id="action_form" method="post">
           			<select name=searchGbn id="search_gbn">
           				<option hidden="" disabled="disabled" selected="selected" value="">검색</option>         				
           				<option value="0">제목</option>	           				            				
           			</select>
           			<input type="text" name="searchText" id="search_text" value="${param.searchText}">
           			<input type="hidden" id="save_text" value="${param.searchText}">
           			<input type="hidden" name="page" id="page" value="${page}">
           			<input type="hidden" name="marketMemberNo" id="market_member_no" value="${marketMemberNo}">
           			<input type="hidden" name="eventNo" id="event_no">
           			<button type="button" id="search_btn">검색</button>            			
           		</form>
           	</div>
        	<div class="paging_wrap">        		
        	</div>
        	<div class="event_dtl_modal">
        	</div>            
        </div>
    </div>
    <div class="bottom_contnr"></div>
</main>
</body>
</html>