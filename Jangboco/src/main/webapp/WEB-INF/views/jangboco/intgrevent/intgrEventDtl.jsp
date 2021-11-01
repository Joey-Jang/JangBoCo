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
	.con {
		display: flex;
	}

	.back_btn_contnr{
		margin-right: 10px;
		padding-top:5px;
		width: 34px;
	}
	
	.back_btn{
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
	
	.page_title_contnr{
		font-size: 25px;
		margin-bottom: 30px;
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
	
	.writer_info_con>span,div{
		margin-right:50px;
	}
	
	.event_info_contnr {
		width: 90%;
		height: 100%;
	}
	
	.event_con{		
		margin-bottom: 15px;
		border: 1px solid #03A64A;
		min-width : 750px;
		height : calc(100% - 300px);
		overflow-y:auto;
		line-break:anywhere;		
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
	checkEventLike();
	cntEventLike();
	
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
			
			$("#action_form").attr("action","intgrEventDtl");
			$("#action_form").submit();
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
			
			$("#action_form").attr("action","intgrEventDtl");
			$("#action_form").submit();
		});
	}
	
	// 목록으로 돌아가기
	$("#back_btn").on("click",function(){
		$("#action_form").attr("action","intgrEventList");
		$("#action_form").submit();
	});
	
	
	// 좋아요 버튼 클릭 이벤트
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
						cntEventLike();
						$("#unlike").hide();
						$("#like").show();
					} else {
						deleteEventLike();
						cntEventLike();
						$("#like").hide();
						$("#unlike").show();
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
      <input type="hidden" id="member_no" name="member_no" value="${member_no}">
      <input type="hidden" id="home_flag" name="home_flag" value="${homeFlag}">
      <input type="hidden" id="menu_idx" name="menu_idx" value="${menuIdx}">
      <input type="hidden" id="sub_menu_idx" name="sub_menu_idx" value="${subMenuIdx}">
   </form>
    <div class="con_contnr">
        <div class="con">
        	<form action="#" id="action_form" method="post">
        		<input type="hidden" name="searchGbn" value="${param.searchGbn}">
        		<input type="hidden" name="searchText" value="${param.searchText}">
        		<input type="hidden" name="page" value="${param.page}">        		 
        		<input type="hidden" name="eventNo" id="event_no" value="${param.eventNo}">
        		<input type="hidden" name="disctName" id="disct_name_data" value="${param.disctName}">	            			
	            <input type="hidden" name="disctNo" id="disct_no" value="${param.disctNo}">       		
        	</form>
        	<div class="back_btn_contnr">
        		<button type="button" class="back_btn" id="back_btn">
        			<img class="btn_img" src = "resources/images/intgrevent/back_button.svg">
				</button> 
        	</div>
        	<div class="event_info_contnr">
	        	<div class="page_title_contnr">행사소식</div>        	        		
        		<div class="event_title_contnr">
        			<span>${data.EVENT_NAME}</span>
        		</div>
        		<div class="writer_info_contnr">
        			<div class="writer_info">
        				<div>
			        		<span>${data.MARKET_NAME}</span><br>        		
			        		<span class="regst_date">${data.REGST_DATE}</span><br>
        				</div>
		        		<div class="market_icon">
		        			<img src="resources/images/intgrevent/market_icon.png">
		        		</div>
        			</div>
	        		<div class="writer_info_con">
		        		<span>행사기간: ${data.START_DATE} ~  ${data.END_DATE}</span>
		        		<div id="like_btn">
		        			<div class="like_unlike_contnr">
				        		<img id="unlike" src="resources/images/intgrevent/unlike.svg">
				        		<img id="like" src="resources/images/intgrevent/like.svg">
		        			</div>
			        		<span id="like_cnt"></span>
		        		</div> 
		        		<span>조회수 ${data.HIT_NUM}</span>
	        		</div>
        		</div>
        		<div class="event_con">
        			${data.CON}
        			ssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssss			
        			        			
        		</div>
        		<div class="move_btn_contnr">
        			<button type="button" class="move_btn" no="${data.EVENT_NO_BEFORE}" id="before_btn">이전글</button>
        			<button type="button" class="move_btn" no="${data.EVENT_NO_NEXT}" id="next_btn">다음글</button>        		
        		</div>        		
        	</div>
        </div>
    </div>
    <div class="bottom_contnr"></div>
</main>
</body>
</html>