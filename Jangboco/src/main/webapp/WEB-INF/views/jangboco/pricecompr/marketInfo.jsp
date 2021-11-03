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
		min-width: 1390px;
		min-height: 1154px;
	}

	.con {
		display: flex;
	}
	
	.btn {
		background-color: #FFFFFF; 
	    cursor: pointer;
		border-width: 1px;
   		border-radius: 6px;
   		border-color: #FFFFFF;		
	}
	
	.btn_img {
		width: 20px;
		filter: invert(44%) sepia(70%) saturate(381%) hue-rotate(103deg) brightness(88%) contrast(85%);
	}
	
	.back_btn_contnr{
		margin-right: 10px;
		padding-top:5px;
		width: 34px
	}
	
	.market_info_outer_contnr{
		width:95%;
	}
	
	.market_info_title{
		font-size : 25px;
	}
	
	.market_info_contnr{
		display: flex;
		flex-direction: row;
		margin-top: 20px;
		padding-bottom: 20px;
		border-bottom: 1px solid #C4C4C4;
		width: 100%;
	}
	
	.market_info_con{
		width: 320px;
		margin-right: 15px;		
	}
	
	.market_info_con>span{
		display : block;
		margin-bottom: 15px;
		overflow: hidden;
		white-space: nowrap;
		text-overflow: ellipsis;
	}
	
	.market_info_addrs_contnr{
		display:none;		
		position: absolute;
		z-index:1000;
		left: 550px;
		top: 249px;
		border: 5px solid #03A64A20;
		border-radius: 10px;
		background-color: #FFFFFF;
		padding: 3px;
	}
	
	.market_info_con>span:nth-child(1){
		font-size: 20px;
	}
	
	/* .market_info_con>span:nth-child(3){
		font-size: 20px;
	} */
	
	.market_img {
		border: 1px solid silver;
		margin-left:15px;
		margin-right : 15px;
		width: 200px;
		height:200px;
	}
	
	.blank_contnr{
		width: calc(100% - 1060px);
	}
	
	.diary_list_contnr{
		width:410px;
		border: 1px solid;
		margin-right: 45px;	
	}
	
	.items_list{
		padding-top: 20px;
	}
	
	.items_slide{
		display: none;		
		flex-wrap: wrap;
		width: 90%;
		height:auto;
		margin:auto;
	}
	.item_row {
		display: flex;
		flex-direction: row;
		width: 50%
	
	}
	.item_img{
		border: 1px solid silver;
		width : 150px;
		height: 150px;
	}
	.item_info{
		border: 1px solid silver;
		width : 290px;
		height: 150px;
		padding: 5px;
	}
	
	.item_info>span:nth-child(1){
		font-size:16px;
	}
	
	.update_date{
		display:block;
		margin-left:180px;
		color: #C4C4C4;
	}
	
	.dot {
		cursor: pointer;
		height: 15px;
		width: 15px;
		margin: 0 2px;
		background-color: #bbb;
		border-radius: 50%;
		display: inline-block;
		transition: background-color 0.6s ease;
	}	
	
	.active2, .dot:hover {
 		background-color: #717171;
	}
	.dot_contnr {
		text-align: center;
		padding-top:10px;
		padding-bottom: 10px;
		border-bottom: 1px solid #C4C4C4;
	}
	
	.items_list, .dot_contnr {
		background-color: #F2740530;
	}
	
	table{
		width:100%;
		min-height:250px;
		text-align: center;
		border-collapse: collapse;
		table-layout:fixed;
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
	
	.event_name {
		text-overflow:ellipsis;
		overflow:hidden;
		white-space: nowrap; 
	}
	
	tobody> .event_name:hover{
		cursor:pointer;
	}		
	
	#search_btn{
		background-color:transparent; 
	    cursor: pointer;
		border: none;
		position : absolute;
		left:195px;
		top:1px;	
	}	
	
	#search_box {
		position : relative;
		margin: auto;
		width: 225px;
		margin-top: 10px;
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
		if(timeCheck("08:00","01:00")){
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
	
	$("#market_info_addrs").on("mouseover",function(){
		$(".market_info_addrs_contnr").css("display","block");		
	});
	
	$("#market_info_addrs").on("mouseout",function(){
		$(".market_info_addrs_contnr").on("mouseover",function(){
			$(".market_info_addrs_contnr").css("display","block");
		});
		
		$(".market_info_addrs_contnr").on("mouseout",function(){
			$(".market_info_addrs_contnr").css("display","none");			
		});
		
		$(".market_info_addrs_contnr").css("display","none");	
	});
	
	$("#back_btn").on("click",function(){
		history.back();
	});
	
});

function timeCheck(startTime,endTime){
	var now= new Date();
	var hours = (now.getHours()<10?'0':'') + now.getHours(); 		
	
	var minutes = (now.getMinutes()<10?'0':'') + now.getMinutes();
	
	var nowTime = hours.toString() + minutes;
	
	startTime = startTime.replace(":", "");
	endTime = endTime.replace(":", "");
	
	// 에러 있는 부분 후순위로 미루고 다음에 수정
	if(startTime >= endTime){
		nowTime = parseInt(nowTime);
		nowTime += 2400;
		endTime = parseInt(endTime);
		endTime += 2400;
		console.log(nowTime);
		console.log(endTime);
	}
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
			var slideIndex = 1;
			showSlides(slideIndex);
		},
		error: function(request, status, error) { 
			console.log(error);
		}
	});
}

function drawItemsList(list){
	var html ="";
	var i = 0;
	
	for(var data of list){
		if(i == 0){
			html += "<div class = \"items_slide\">";			
		} else if(i == 4){
			html += "<div class = \"items_slide\">";			
		} else if(i == 8){
			html += "<div class = \"items_slide\">";			
		} else if(i == 12){
			html += "<div class = \"items_slide\">";			
		} else if(i == 16){
			html += "<div class = \"items_slide\">";			
		};
		
		html += "<div class=\"item_row\">            "               ;
		html += "	<div class=\"item_img\"></div>   "               ;
		html += "	<div class=\"item_info\">        "               ;
		html += "		<span>"+data.ITEMS_NAME +"</span><br>        "   ;
		html += "		<span>판매규격: "+data.SELL_STD +"</span><br>        "   ;
		html += "		<span>가격: "+data.PRICE +"원</span><br>        "        ;
		html += "		<span>평균가격: "+data.AVG_PRICE+"원</span><br>        "   ;
		html += "		<span>비고: "+data.NOTE +"</span><br>        "		 ;     			            			
		html += "		<span class=\"update_date\">"+data.UPDATE_DATE +"</span><br>        "   ;
		html += "	</div>                         "                 ;
		html += "</div>                            "                 ;
				
		if(i == 3){
			html += "</div>";			
		} else if(i == 7){
			html += "</div>";			
		} else if(i == 11){
			html += "</div>";			
		} else if(i == 15){
			html += "</div>";			
		} else if(i == list.length-1){
			html += "</div>";			
		};
		i++;
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
	
	if(list.length == 0){
		
    	html += "<tr>                                    ";
		html += "	<td colspan=\"7\">게시글이 없습니다.</td>	";            		
		html += "</tr>                                   ";
		
		$("table").css("min-height","auto");
	}
	
	for( var data of list){		
		html += "<tr>        ";
		html += "    <td>"+ data.EVENT_NO +"</td>                   ";
		html += "    <td  no=\""+data.EVENT_NO +"\" id=\"go_event_dtl\" class=\"event_name\">";
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
	
	html += "<div class=\"paging_btn\" id=\"first_btn\">    "
	html += "	<span page=\"1\">처음</span>    "
	html += "</div>                  "
	html += "<div class=\"paging_btn\">                   "
	if($("#page").val()<=10){		
		html += "	<span page=\"1\">이전</span>    "
	} else {
		html += "	<span page=\"" +(pb.startPcount-1) + "\">이전</span>    "		
	}	
	html += "</div>                  "
	for(var i=pb.startPcount; i<=pb.endPcount; i++){		
		if($("#page").val()==i){
			html += "<div class=\"paging_btn\">                   "
			html += "	<span page=\""+ i + "\"><b>"+i+"</b></span>       "
			html += "</div>                  "			
		} else {
			html += "<div class=\"paging_btn\">                   "
			html += "	<span page=\""+ i + "\">"+i+"</span>       "
			html += "</div>                  "						
		}
	}
	
	if(pb.endPcount== pb.maxPcount){		
		html += "<div class=\"paging_btn\">                   "
		html += "	<span page=\""+pb.maxPcount +"\">다음</span>    "
		html += "</div>                  "
	} else {
		html += "<div class=\"paging_btn\">                   "
		html += "	<span page=\""+(pb.endPcount+1) +"\">다음</span>    "
		html += "</div>                  "		
	}
	html += "<div class=\"paging_btn\" id=\"last_btn\">     "
	html += "	<span page=\""+ pb.maxPcount +"\">마지막</span>  "
	html += "</div>                  "
	
	$(".paging_wrap").html(html);
}

// 품목 목록 슬라이드
function currentSlide(n) {
	showSlides(slideIndex = n);
}

function showSlides(slideIndex) {
	var i;
	var slides = document.getElementsByClassName("items_slide");
	var dots = document.getElementsByClassName("dot");
	
	if (slideIndex > slides.length) {slideIndex = 1}
	if (slideIndex < 1) {slideIndex = slides.length}
	for (i = 0; i < slides.length; i++) {
	    slides[i].style.display = "none";
	}
	for (i = 0; i < dots.length; i++) {
	    dots[i].className = dots[i].className.replace(" active2", "");
	}
	
	slides[slideIndex-1].style.display = "flex";
	dots[slideIndex-1].className += " active2";		
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
        	<div class="market_info_addrs_contnr">
        	<c:choose>
           		<c:when test="${!empty marketMemberNo}">
		           <span>${marketInfo.ADDRS} ${marketInfo.DTL_ADDRS}</span>			            	
           		</c:when>
           		<c:otherwise>           			
           			<span>${marketInfo.MARKET_ADDRS}</span>	            				
        		</c:otherwise>
			</c:choose>
				
           	</div>
        	<div class="back_btn_contnr">
	        	<button type="button" class="btn" id="back_btn">
		        	<img class="btn_img" src = "resources/images/intgrevent/back_button.svg">     	
				</button>        	
        	</div>
        	<div class="market_info_outer_contnr">
	            <div class="market_info_title">우리동네 가격 비교</div>
	            <div class="market_info_contnr">
	            	<div class="market_img"></div>
	            	<div class="market_info_con">
	            		<c:choose>
	            			<c:when test="${!empty marketMemberNo}">
				            	<span>${marketInfo.MARKET_NAME} ${marketInfo.BRANCH_NAME}</span>				            	
				            	<span id="market_info_addrs">${marketInfo.ADDRS} ${marketInfo.DTL_ADDRS}ssssssssssssssssssssss</span>
				            	<span>${marketInfo.PHONE_NUM}</span>
				            	<span>${marketInfo.START_TIME} - ${marketInfo.END_TIME}</span>
				            	<span id="time_check"></span>			            	
	            			</c:when>
	            			<c:otherwise>
	            				<span>${marketInfo.MARKET_NAME}</span><br>
	            				<span id="market_info_addrs">${marketInfo.MARKET_ADDRS}</span>	            				
	            			</c:otherwise>
	            		</c:choose>
	            	</div>
	            	<div class="blank_contnr"></div>
	            	<div class="diary_list_contnr">
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
	            			<span>품목명</span><br>
	            			<span>재고여부</span><br>
	            			<span>가격</span><br>
	            			<span>지역평균</span> <br>           			            			
	            		</div>
	            	</div>            	
	            </div>
	            <div class="dot_contnr">
				  <span class="dot" onclick="currentSlide(1)"></span>
				  <span class="dot" onclick="currentSlide(2)"></span>
				  <span class="dot" onclick="currentSlide(3)"></span>
				  <span class="dot" onclick="currentSlide(4)"></span>
				</div>				
	            
	            <div class="event_list_wrap">	            	
		            <table>
		                <thead>
		                    <tr>
		                        <th style="width:5%">#</th>
		                        <th style="width:30%" class="event_name">행사제목</th>
		                        <th style="width:10%">등록일</th>
		                        <th style="width:9%">시작</th>
		                        <th style="width:9%">종료</th>
		                        <th style="width:5%">♥</th>
		                        <th style="width:7%">조회수</th>
		                    </tr>
		                </thead>
		                <tbody class="event_list">	            	
		            	</tbody>
		            </table>
	        	</div>
	        	<div class="search_form">
	           		<form action="#" id="action_form" method="post">
	           			<input type="hidden" id="save_text" value="${param.searchText}">
	           			<input type="hidden" name="page" id="page" value="${page}">
	           			<input type="hidden" name="marketMemberNo" id="market_member_no" value="${marketMemberNo}">
	           			<input type="hidden" name="eventNo" id="event_no">
	           			<div id="search_box">
		           			<select name=searchGbn id="search_gbn">
		           				<option hidden="" disabled="disabled" selected="selected" value="">검색</option>         				
		           				<option value="0">제목</option>	           				            				
		           			</select>
		           			<input type="text" name="searchText" id="search_text" value="${param.searchText}"  placeholder="Search">
		           			<button type="button" id="search_btn">
		           				<img class="btn_img" src = "resources/images/intgrevent/search_button.svg">
		           			</button>            			
	           			</div>
	           		</form>
	           	</div>
	        	<div class="paging_wrap">        		
	        	</div>
        	</div>        	
        	<div class="event_dtl_modal">
        	</div>            
        </div>
    </div>
    <div class="bottom_contnr"></div>
</main>
</body>
</html>