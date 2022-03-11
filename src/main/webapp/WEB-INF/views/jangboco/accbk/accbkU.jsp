<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>가계부-작성</title>
<link rel="preconnect" href="https://fonts.gstatic.com">
<link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100;300;400;500;700;900&display=swap">
<link rel="stylesheet" type="text/css" href="resources/css/layout/default.css">
<link rel="stylesheet" href="resources/css/accbk/accbk.css" type="text/css">
<script type="text/javascript" src="resources/script/jquery/jquery-1.12.4.min.js"></script>
<script type="text/javascript" src="resources/script/layout/default.js"></script>
<script type="text/javascript" src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=9a34fa20b8bdbafa1061701c69f892c1&libraries=services"></script>
<script type="text/javascript" src="resources/script/layout/addrsMapApi.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	$("#update_cancel_btn").on("click",function(){
		history.back();
	});
	
	//구입처_직접입력_선택시_나타나고_다른항목_선택시_사라짐
	
	$('input.market_no').on("click", function() {
		
		if($(this).prop('checked')){
		   $('input.market_no').prop('checked',false);
		   $(this).prop('checked',true);
		}
		
		if($(this).hasClass("others")){
			$("#market_name").attr("disabled",false);		
		} else {
			$("#market_name").attr("disabled",true);
			$("#market_name").val("");		
			// $(this).val(); 
		}
		
	});
	
	// input(#market_name)에 내용 입력하기 위해 click하면 hide()됨 ... 왜 .. why
	
	

	
	//품목_직접입력_선택시_나타나게
	$("#items").change(function(){
		$("#items option:selected").each(function(){
			
			//option 직접입력을 선택하면
			if($(this).attr('class')=="items_others"){ 
				$("#items_name").show(); //직접입력 할 수 있는 input창이 나타남
			
			//직접입력이 아닌 다른 option을 적용 할 경우 
			}else{
				$("#items_name").hide(); // 직접입력 할 수 있는 input 창이 사라짐
				$("#items_name").val(""); // 그리고 거기 적힌 값을 어찌저찌 해야하는데 어떻게 하지 ?? 
				
			}
		});
		
		
		
		
		/* if($("#items").attr('class')=="items_others"){
		}else if($("#items").attr('class')!="items_others"){
		} */
	});
	//나중에 DB에 items의 value 값 넣어줄 때, java단?에서 items(othersItems)와 itemsOthers의 값을 체크하여
	// 올바른 값을 넣고 DB 처리해주면 됨 . 
	
	//수정버튼
	   $("#update_btn").on("click", function(){
		if(checkVal("#buy_qnt")){
			alert("구매량을 입력해주세요.");
			$("#buy_qnt").focus();
		}else if(checkVal("#cost")){
			alert("금액을 입력해주세요.");
			$("#cost").focus();
		}else if(checkVal("#buy_date")){
			alert("구입일자를 등록해주세요.");
		}else{
			
			var params = $("#update_form").serialize();
			
			$.ajax({
				url : "accbkUAjax",
				type : "post",
				dataType : "json",
				data : params,
				success : function(result){
					if (result.msg == "success") {
						location.href = "accbkR";
						alert("등록 성공");
					}else if(result.msg == "failed") {
						alert("작성 실패");
					}else{
						alert("작성 중 문제 발생");
					}
				},
				error : function(request,status,error){
					console.log(error);
				}
			}); // ajax끝
		}//else끝
	}); // updateBtn.on(click) 끝 
	 
	
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
			<form action="#" id="update_form" method="post">
			<input type="hidden" name="accbk_no" value="${param.update_no}">
			<!--품목, 구매량,금액, 비고 +버튼 누르면 추가할 수 있게.  -->
			구입처 
			<div id="buy_market">
				<c:set var="cnt" value="0"></c:set>
				<c:forEach var="data" items="${list}">
					<c:set var="cnt" value="${cnt+1}"></c:set>
			 		<input type="checkbox" name="market_no" class="market_no" value="${data.MARKET_NO}"><label>${data.MARKET_NAME}</label>
			 		<input type="hidden" name="market_name" value=""> 
			 		<c:if test="${cnt%5==0}">
				 		<br>
				 	</c:if>
			 	</c:forEach>
				<input type="checkbox" name="market_no" class="market_no others" value=""><label>직접입력</label>
				<input type="text" id="market_name" name="market_name" disabled="disabled"><br>
			</div>
			<br>
			품목
			<select id="items" name="items_no">
				<c:forEach var="dt" items="${itemsList}">
					<option value="${dt.ITEMS_NO}">${dt.ITEMS_NAME}</option>	
				</c:forEach>
				<option class="items_others" value="">직접입력</option>
			</select>
			<input type="text" id="items_name" name="items_name">
			
			<br>
			구매량
			<input type="text" id="buy_qnt" name="buy_qnt">	<br>
			금액
			<input type="text" id="cost" name="cost">원
			<br>
			비고 <input type="text" id="note" name="note"><br>
			구입 일자 <input type="date" id="buy_date" name="buy_date" >
			
			<br> 
			</form>
			<input type="button" value="수정" id="update_btn">
			<input type="button" value="취소" id="update_cancel_btn">
        </div>
    </div>
    <div class="bottom_contnr"></div>
</main>
</body>
</html>