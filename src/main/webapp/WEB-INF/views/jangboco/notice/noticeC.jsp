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
<script type="text/javascript" src="resources/script/jquery/jquery-1.12.4.min.js"></script>
<script type="text/javascript" src="resources/script/layout/default.js"></script>
<script type="text/javascript" src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=9a34fa20b8bdbafa1061701c69f892c1&libraries=services"></script>
<script type="text/javascript" src="resources/script/layout/addrsMapApi.js"></script>
<script type="text/javascript" src="resources/script/ckeditor/ckeditor.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	CKEDITOR.replace("con",{
		resize_enabled : false,
		language : "ko",
		enterMode : "2"
	});
	
	//취소버튼
	$("#cancel_btn").on("click",function(){
		$("#action_form").attr("action","noticeR");
		$("#action_form").submit();
		
	});
	
	//엔터키 폼실행 막기
	$("#write_form").on("keypress", "input", function(){
		if (event.KeyCode == 13) {  //13 = 엔터키 ; 엔터키가 눌러졌을 때
			return false;			//form 실행을 하지 않음
		}
	});
	
	
	$("#write_btn").on("click",function(){
		//ck에디터 중에 con과 관련된 객체에서 데이터를 취득하여 textarea인 con에 값을 넣는다.
		$("#con").val(CKEDITOR.instances['con'].getData());
		
		if (checkVal("#title")) {
			alert("제목을 입력해 주세요.");
			$("#title").focus();
		}else if(checkVal("#con")){
			alert("내용을 입력해주세요");
		}else if(checkVal("#notice_type")){
			alert("공지유형을 선택해주세요");
		}else{
			
				var params = $("#write_form").serialize();
				
				$.ajax({
					url : "noticeCUDAjax",
					type : "post",
					dataType : "json",
					data : params,
					success : function(result){
						if (result.msg == "success") {
							location.href ="noticeR";
						} else if(result.msg =="failed") {
							alert("공지 작성에 실패했습니다.");
						}else{
							alert("공지 작성 중 문제가 발생했습니다.");
						}
					},
					error : function(request, status, error){
						console.log(erorr);
					}
				}); //ajax 끝
				}
		});
		
	
});

function checkVal(sel) {
	if($.trim($(sel).val()) == "") {
		return true;
	} else {
		return false;
	}
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
		<form action="#" id="action_form" method="post">
	       		<input type="hidden" name="search_gbn" value="${param.search_gbn}">
	       		<input type="hidden" name="search_text" value="${param.search_text}">
	       		<input type="hidden" name="page" value="${param.page}">
	   </form>
		<div id="write_contnr">
			<form action="#" id="write_form" method="post">
			<input type="hidden" name="gbn" value="c">
			<select  id="notice_type" name ="noticeType">
				<option hidden="" disabled="disabled" selected="selected">-유형-</option>
				<option value="1">일반회원</option>
				<option value="2">마켓회원</option>
			</select> 
			제목 <input type="text" id="title" name="title"><br>
			내용 <br>
			<textarea rows="5" cols="5" id="con" name="con"></textarea>
			<input type="button" value="저장" id="write_btn" class="write_btn">
			<input type="button" value="취소" id="cancel_btn" class="cancel_btn">
			</form>
		</div>		
		</div>
		
	</div>
 <div class="bottom_contnr"></div>
</main>
</body>
</html>