<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공지사항 글쓰기</title>
<link rel="preconnect" href="https://fonts.gstatic.com">
<link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100;300;400;500;700;900&display=swap">
<link rel="stylesheet" type="text/css" href="resources/css/layout/default.css">
<link rel="stylesheet" href="resources/css/notice/noticeDtl.css" type="text/css">
<script type="text/javascript" src="resources/script/jquery/jquery-1.12.4.min.js"></script>
<script type="text/javascript" src="resources/script/layout/default.js"></script>
<script type="text/javascript" src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=9a34fa20b8bdbafa1061701c69f892c1&libraries=services"></script>
<script type="text/javascript" src="resources/script/layout/addrsMapApi.js"></script>
<script type="text/javascript">
$(document).ready(function(){

	//목록으로 돌아가기
	$("#back_btn").on("click",function(){
		$("#action_form").attr("action","noticeR");
		$("#action_form").submit();
		
	});
	//수정
		$("#update_btn").on("click", function() {
			console.log("왜안될까");
			$("#action_form").attr("action", "noticeU");
			$("#action_form").submit();
		});
		// 이전글에 대한 데이터가 없을 시 
		if($("#before_btn").attr("no")==-1){
			
			$("#before_btn").css({
				"background-color":"#C4C4C4",
				"cursor":"auto"
			});		
			
		} else {
			// 행사소식 이전글
			$("#before_btn").on("click",function(){
				console.log("으앜");
				$("#notice_no").val($(this).attr("no"));
				
				$("#action_form").attr("action","noticeDtl");
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
				
				
				$("#notice_no").val($(this).attr("no"));
				
				$("#action_form").attr("action","noticeDtl");
				$("#action_form").submit();
			});
		}
		
		$("#del_btn").on("click", function() {
			if(confirm("삭제하시겠습니까?")) {
				//Ajax
				var params = $("#action_form").serialize();
				
				$.ajax({
					url : "noticeCUDAjax",
					type :"post",
					dataType : "json",
					data : params,
					success : function(result){
						if (result.msg == "success") {
							location.href = "noticeR";
						} else if(result.msg == "failed"){
							alert("삭제에 실패했습니다.");
						} else{
							alert("삭제 중 문제가 발생했습니다.");
						}
					},
					error : function(request,status,error){
						console.log(error);
					}
				});
			}
		});


});
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
			<form action="#" id="action_form" method="post">
				<input type="hidden" name="gbn" value="d" >
	       		<input type="hidden" name="search_gbn" value="${param.search_gbn}">
	       		<input type="hidden" name="search_text" value="${param.search_text}">
	       		<input type="hidden" name="page" value="${param.page}">
	       		<input type="hidden" name="noticeNo" id="notice_no" value="${param.noticeNo}">        		 
	        </form>
			<div class="back_btn_contnr">
        		<button type="button" class="back_btn" id="back_btn">
        			<img class="btn_img" src = "resources/images/intgrevent/back_button.svg">
				</button>
        	</div>
        	
        	<div class="notice_wrap_contnr">
        		<div class="dtl_title">공지 사항</div>
        		<div class="notice_title">
        			<span>${data.TITLE}</span>
        		</div>
        		<div class="dtl_info_contnr">
        			<div class="dtl_hit">${data.HIT_NUM}</div>
        			<div class="regst_date"${data.REGST_DATE}></div>
        		</div>
        		<div class="dtl_con">${data.CON}</div>
        		<input type="button" value="수정" id="update_btn">
        		<input type="button" value="삭제" id="del_btn">
        		<!-- 상황 봐보고 추가   -->
        		 <div class="move_btn_contnr">
        			<button type="button" class="move_btn" no="${data.NOTICE_NO_BEFORE}" id="before_btn">이전글</button>
        			<button type="button" class="move_btn" no="${data.NOTICE_NO_NEXT}" id="next_btn">다음글</button>        		
        		</div>       
        	</div>	
		</div>
	</div>
 <div class="bottom_contnr"></div>
</main>
</body>
</html>