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
		justify-content:center;
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
			
	
	
	.items_list{
		padding-top: 20px;
	}
	
	.items_slide{
		display: none;		
		flex-wrap: wrap;
		width: 923px;
		height:auto;
		margin:auto;
	}
	.item_row {
		display: flex;
		flex-direction: row;
		width: 50%
	
	}
	.item_img{
		border-bottom: 1px solid silver;
		width : 150px;
		height: 150px;
		background-color: #dff4e8;
	}
	
	#item_img{
		width: 100%;
		height: 100%;		
	}
	
	.item_info{
		border-bottom: 1px solid silver;
		width : 290px;
		height: 150px;
		padding: 5px;
		background-color: #dff4e8;
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
	
	tbody .event_name:hover{
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
		width: 240px;
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
	
	/* *********************************************************** */
	/* *********************************************************** */
	/* 다이어리 */
	/* *********************************************************** */
	/* *********************************************************** */
	.jangbc_diary_contnr{
  		position: relative;    
    	width: 420px;
    	margin-right: 45px;
	}
	
	.jangbc_diary_slides{
	    width: 410px;
	    margin: auto;
    	display: none;
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
	  width: 50%;
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
		left:-22px;
	}	
	/* Position the "next button" to the right */
	.next {
      right: -22px;
	  border-radius: 0 3px 3px 0;
	}
	
	/* On hover, add a black background color with a little bit see-through */
	.prev:hover, .next:hover {
	  background-color: #03A64A;
	  color:#FFFFFF;
	}
	
	/* *********************************************************** */
	/* *********************************************************** */
	/* 모달창  */
	/* *********************************************************** */
	/* *********************************************************** */
	.event_dtl_modal {
		/* position:absolute; */
		font-family: 'Noto Sans KR', sans-serif;
	    font-size: 11pt;
	    font-weight: 400;	   
	    display:none;
	    height: 100%;
	}
	
	.btn_img {
		width: 20px;
		filter: invert(44%) sepia(70%) saturate(381%) hue-rotate(103deg) brightness(88%) contrast(85%);
	}
	
	.market_icon img{
		width:45px;
		height: 45px;
	}
	
	.move_btn {
		background-color: #03A64A;
		color : #FFFFFF;
		width : 100px;
		border-width: 1px;
		border-radius: 6px;	
		cursor: pointer;
		border-color: #FFFFFF;	
	}
	
	.writer_info{
		display:flex;
	}
	
	.page_title_btn_contnr{
		display: flex;
    	justify-content: space-between;
	}
	
	.page_title_contnr{
		font-size: 25px;
		margin-bottom: 30px;
	}
	
	.modal_close_btn{
	    width: 35px;
	    height: 35px;
	    text-align: center;
	    font-size: 22px;
	    border: 1px solid #C4C4C4;
	    color: #03A64A;
	    cursor: pointer;	
	}
	
	.event_title_contnr{
		min-width: 750px;
		
		font-size: 35px;
		font-weight:bold;
		overflow: hidden;
		text-overflow:ellipsis;
		white-space: nowrap;
		margin-bottom: 15px;
	}
	
	.writer_info{
		margin-bottom: 15px;
		margin-left: 10px;
	}
	
	.writer_info div:nth-child(1) {
		margin-right:10px;
	}
	
	.writer_info div:nth-child(1) span:nth-child(1){
		font-size: 20px;
		font-weight: bold;
	}
	
	.regst_date{
		font-size:16px;
		color: #C4C4C4;
	}
	
	.writer_info_con {
		display: flex;
		font-size:16px;				
		margin-bottom: 15px;
	}
	
	.writer_info_con>span,#like_btn{
		margin-right:50px;
	}
	
	.event_info_contnr {
		height: 100%;
		background-color: #FFFFFF;
		padding: 10px;
	}
	
	.event_con{		
		margin-bottom: 15px;
		border: 1px solid #03A64A;
		min-width : 750px;
		height : calc(100% - 300px);
		overflow-y:auto;
		line-break:anywhere;	
		padding: 15px;	
	}
	.move_btn_contnr {
		display: flex;
		flex-direction: row;
		justify-content: space-between;
	}
	
	#unlike{
		display:none;
		width: 25px;
		height:25px;		
	}
	
	#like{
		display:none;
		width: 25px;
		height:25px;		
	}
	
	#like_btn{
		display: flex;
		text-align: center;
	}	
	.like_unlike_contnr{
		width: 25px;
		height:25px;
		margin-right:20px;		
	}
	.like_unlike_contnr:hover{
		cursor: pointer;
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
	
	$("tbody").on("click","#go_event_dtl",function(){
		$("#event_no").val($(this).attr("no"));
		
		reloadModal();
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
		html += "	<div class=\"item_img\"><img id=\"item_img\" src=\"resources/images/itemsInfo/"+data.IMG_URL+".jpg\" onerror=\"this.src='resources/images/itemsInfo/noimg.png'\"></div>   "               ;
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

function reloadModal(){
	var params = $("#action_form").serialize();
	
	$.ajax({ 
		url: "eventModalAjax", 
		type: "post", 
		dataType: "json", 
		data: params, 
		success : function(res) {			
			drawEventModal(res.data);
			checkEventLike();
			cntEventLike();
			$(".con").hide();
			$(".event_dtl_modal").show();
			$(".con_contnr").css("background-color","#03A64A20");
			// 이전글에 대한 데이터가 없을 시 
			if($("#before_btn").attr("no")==-1){
				$("#before_btn").css({
					"background-color":"#C4C4C4",
					"cursor":"auto"
				});		
				
			} else {
				// 행사소식 이전글
				$("#before_btn").on("click",function(){
					$("#event_no").val($(this).attr("no"));
					
					reloadModal();
				});
			}
			// 다음글에 대한 데이터가 없을 시 	
			if($("#next_btn").attr("no")==-1){
				$("#next_btn").css({
					"background-color":"#C4C4C4",
					"cursor":"auto"
				});		
				
			} else {
				// 행사소식 다음글
				$("#next_btn").on("click",function(){					
					$("#event_no").val($(this).attr("no"));
					
					reloadModal();
				});
			}
			
			// 좋아요 버튼 클릭 이벤트(로그인 / 비로그인시 처리)
			$(".like_unlike_contnr").on("click",function(){
				if($("#member_no").val() != null && $("#member_no").val() != ''){
					var params = {
							"memberNo": $("#member_no").val(),
							"eventNo": $("#event_no").val()
						 };
			
					$.ajax({
						url: "checkEventLikeAjax",
						type: "post",
						dataType: "json",
						data: params,
						success: function(res) {
							if(res.checkEventLike==0) {
								addEventLike();						
								
							} else {
								deleteEventLike();
								
							}
						},
						error: function(request, status, error) {
							console.log(error);
						}
					});	
					
				} else {
					if(confirm("로그인을 하셔야합니다.")){
						$("#go_form").attr("action", "loginMain	");
						$("#go_form").submit();				
					}
				}
			});
			
			$(".modal_close_btn").on("click",function(){
				$(".con_contnr").css("background-color","");
				$(".event_dtl_modal").hide();
				$(".event_dtl_modal").html("");
				reloadEventList();
				$(".con").show();
				
				
			});
		},
		error: function(request, status, error) { 
			console.log(error);
		}
	});
	
}

function drawEventModal(data){
	var html = "";	
	
	html += "<div class=\"event_info_contnr\">                                                                              ";
	html += "	<div class=\"page_title_btn_contnr\">";
	html += "	<div class=\"page_title_contnr\">행사소식</div>        	        		                                  ";
	html += "	<div class=\"modal_close_btn\">X</div> ";	
	html += "	</div>";	
	html += "	<div class=\"event_title_contnr\">                                                                          ";
	html += "		<span>"+ data.EVENT_NAME +"</span>                                                                                 ";
	html += "	</div>                                                                                                    ";
	html += "	<div class=\"writer_info_contnr\">                                                                          ";
	html += "		<div class=\"writer_info\">                                                                             ";
	html += "			<div>                                                                                             ";
    html += "    		<span>"+ data.MARKET_NAME +"</span><br>        		                                                              ";
    html += "    		<span class=\"regst_date\">"+ data.REGST_DATE +"</span><br>                                                        ";
	html += "			</div>                                                                                            ";
    html += "		<div class=\"market_icon\">                                                                             ";
    html += "			<img src=\"resources/images/intgrevent/market_icon.png\">                                           ";
    html += "		</div>                                                                                                ";
	html += "		</div>                                                                                                ";
	html += "	<div class=\"writer_info_con\">                                                                             ";
    html += "		<span>행사기간: "+ data.START_DATE +" ~  "+ data.END_DATE +"</span>                                                               ";
    html += "		<div id=\"like_btn\">                                                                                   ";
    html += "			<div class=\"like_unlike_contnr\">                                                                  ";
	html += "        		<img id=\"unlike\" src=\"resources/images/intgrevent/unlike.svg\">                                ";
	html += "        		<img id=\"like\" src=\"resources/images/intgrevent/like.svg\">                                    ";
    html += "			</div>                                                                                            ";
    html += "    		<span id=\"like_cnt\"></span>                                                                       ";
    html += "		</div>                                                                                                ";
    html += "		<span>조회수 "+ data.HIT_NUM +"</span>                                                                            ";
	html += "	</div>                                                                                                    ";
	html += "	</div>                                                                                                    ";
	html += "	<div class=\"event_con\">"+ data.CON +"</div>";
	html += "	<div class=\"move_btn_contnr\">                                                                             ";
	html += "		<button type=\"button\" class=\"move_btn\" no=\""+ data.EVENT_NO_BEFORE +"\" id=\"before_btn\">이전글</button>   ";
	html += "		<button type=\"button\" class=\"move_btn\" no=\""+ data.EVENT_NO_NEXT +"\" id=\"next_btn\">다음글</button>       "; 		
	html += "	</div>        		                                                                                      ";
	html += "</div>                                                                                                       ";
	
	$(".event_dtl_modal").html(html);
}

//좋아요 여부
function checkEventLike() {
	if($("#member_no").val() != null && $("#member_no").val() != ''){
		var params = {
						"memberNo": $("#member_no").val(),
						"eventNo": $("#event_no").val()
					 };
		
		$.ajax({
			url: "checkEventLikeAjax",
			type: "post",
			dataType: "json",
			data: params,
			success: function(res) {
				if(res.checkEventLike==0) {
					$("#like").hide();
					$("#unlike").show();
				} else {
					$("#unlike").hide();
					$("#like").show();
				}
			},
			error: function(request, status, error) {
				console.log(error);
			}
		});		
	} else {
		$("#like").hide();
		$("#unlike").show();		
	}
}

//좋아요 개수
function cntEventLike() {
	var params = {
					"eventNo": $("#event_no").val()
				 };
	
	$.ajax({
		url: "cntEventLikeAjax",
		type: "post",
		dataType: "json",
		data: params,
		success: function(res) {
			$("#like_cnt").text(res.cntEventLike);
		},
		error: function(request, status, error) {
			console.log(error);
		}
	});
}

// 좋아요 누르기
function addEventLike(){
	var params = {
					"eventNo":$("#event_no").val(),
					"memberNo": $("#member_no").val()
				};
	
	$.ajax({
		url: "addEventLikeAjax",
		type: "post",
		dataType: "json",
		data: params,
		success: function(res) {
			console.log(res.result);
			$("#unlike").hide();
			$("#like").show();
			cntEventLike();
		},
		error: function(request, status, error) {
			console.log(error);
		}
	});	
}

//좋아요 취소
function deleteEventLike(){
	var params = {
					"eventNo":$("#event_no").val(),
					"memberNo": $("#member_no").val()
				};
	
	$.ajax({
		url: "deleteEventLikeAjax",
		type: "post",
		dataType: "json",
		data: params,
		success: function(res) {
			console.log(res.result);
			$("#like").hide();
			$("#unlike").show();
			cntEventLike();
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
      <input type="hidden" id="member_no" name="member_no" value="${sMNo}">
      <input type="hidden" id="home_flag" name="home_flag" value="${homeFlag}">
      <input type="hidden" id="menu_idx" name="menu_idx" value="${menuIdx}">
      <input type="hidden" id="sub_menu_idx" name="sub_menu_idx" value="${subMenuIdx}">
   	</form>
    <div class="con_contnr">
    	<div class="event_dtl_modal">	       	
	     </div>  
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
				            	<span id="market_info_addrs">${marketInfo.ADDRS} ${marketInfo.DTL_ADDRS}</span>
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
		              		</div>
		            	</div>
		            	
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
		              		</div>  			
		            	</div>
		            	<a class="prev" onclick="plusSlides(-1)">&#10094;</a>
  						<a class="next" onclick="plusSlides(1)">&#10095;</a>
	            	</div>
	            	<script type="text/javascript">
			            var slideIndex = 1;
			            diarySlides(slideIndex);
			
			            // Next/previous controls
			            function plusSlides(n) {
			            	diarySlides(slideIndex += n);
			            }			            
			
			            function diarySlides(n) {
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
        </div>
    </div>
    <div class="bottom_contnr"></div>
</main>
</body>
</html>