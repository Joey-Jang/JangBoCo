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
<link rel="stylesheet" href="resources/css/accbk/accbkC.css" type="text/css">
<script type="text/javascript" src="resources/script/jquery/jquery-1.12.4.min.js"></script>
<script type="text/javascript" src="resources/script/layout/default.js"></script>
<script type="text/javascript" src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=9a34fa20b8bdbafa1061701c69f892c1&libraries=services"></script>
<script type="text/javascript" src="resources/script/layout/addrsMapApi.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	
	/* // 체크박스_하나만_선택되게
	 $('input[type="checkbox"][name="market_no"]').click(function(){
		  
	}); */
	getDisctList();
	
	
	$("#write_cancel_btn").on("click", function(){
		history.back();
	});
	
	//구입처_직접입력_선택시_나타나고_다른항목_선택시_사라짐
	
/* 	$('input.market_no').on("click", function() {
		
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
	 */
	 
	 //마켓 검색 버튼 엔터키 비동기화 
	 $("#search_market_name").on("keypress", function(event){
		if (event.keyCode==13) {
			$("#search_market_btn").click();
			return false;
		}
	 });
	
	// 마켓 검색 버튼 클릭
	$("#search_market_btn").on("click",function(){
		
		var params = {
				"disctNo" : $("#disct_gbn > option:selected").val(),
				"searchMarketName" : $("#search_market_name").val()
		};
		
		$.ajax({
			url:"searchAccbkMarketAjax",
			type:"post",
			dataType:"json",
			data:params,
			success:function(result){
				drawMarketList(result.marketList);
				/* $("#market_list").show();
				$("#market_branch_name_contnr").show(); */
			},
			error:function(request,status,error){
				console.log(error);
			}
		})
	});
	
	//마켓 검색 목록 호버
	$("#market_list").on("mouseover","span",function(){
		$(this).parent().children(".marker").css("border-left","2px solid #03A64A");
	});
	$("#market_list").on("mouseout","span",function(){
		$(this).parent().children(".marker").css("border-left","");
	});
	
	//마켓 검색 목록 클릭 시 
	var marketName ="";
	$("#market_list").on("click","span",function(){
		$("#market_list").hide();
		
		$("#market_no").val($(this).parent().attr("market_no"));
		marketName = $(this).text();
		
		var params = {
				"marketNo":$("#market_no").val()
		};
		
		$.ajax({
			 url: "searchAccbkBranchAjax",
	         type: "post",
	         dataType: "json",
	         data: params,
	         success: function(result) {
	            if(result.branchList.length==0) {
	               $("#select_market_branch_name").val(marketName);
	               $("#select_market_branch_name").show();
	               
	            } else {
	               drawBranchList(result.branchList);
	               $("#branch_list").show();
	            }
	         },
	         error: function(request, status, error) {
	            console.log(error);
	         }
		});//ajax end
		
	});
	
	//지점 검색 목록 클릭 
	var branchName = "";
	$("#branch_list").on("click","span",function(){
		$("#branch_list").hide();
		
		branchName = $(this).text();
		
		$("#market_name").val(marketName+" "+branchName);
		$("#select_market_branch_name").val(marketName+" "+branchName);
		$("#select_market_branch_name").show();
	});
	
	//마켓 직접 입력 
	//var othersMarketName ="";
	$("#others_market_btn").on("click",function(){
		$("#market_no").val("");
		$("#search_market_contnr").hide();
		$("#others_market_name_contnr").show();
		$("#select_market_branch_name").hide();
		
		/* othersMarketName = $("#market_name").text();
		$("#select_market_branch_name").val(othersMarketName); */
		
	});
	
	
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
		
	/* //품목 검색 엔터키 비동기화 
	$("#search_items_name").on("keypress", function(event) {
		if(event.keyCode==13) {
			$("#search_items_btn").click();
			return false;
		}
	}); */
	

		/* if($("#items").attr('class')=="items_others"){
		}else if($("#items").attr('class')!="items_others"){
		} */
	});
	//나중에 DB에 items의 value 값 넣어줄 때, java단?에서 items(othersItems)와 itemsOthers의 값을 체크하여
	// 올바른 값을 넣고 DB 처리해주면 됨 . 
	
	//쓰기버튼
	   $("#write_btn").on("click", function(){
		if(checkVal("#buy_qnt")){
			alert("구매량을 입력해주세요.");
			$("#buy_qnt").focus();
		}else if(checkVal("#cost")){
			alert("금액을 입력해주세요.");
			$("#cost").focus();
		}else if(checkVal("#buy_date")){
			alert("구입일자를 등록해주세요.");
		}else{
			
			var params = $("#write_form").serialize();
			
			$.ajax({
				url : "accbkCAjax",
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
	}); // writeBtn.on(click) 끝 
	 
	
});

 function checkVal(sel) {
	if($.trim($(sel).val()) == "") {
		return true;
	} else {
		return false;
	}
}

 //지역구 목록
function drawDisctList(disctList) {
   var html = "";
   
   html += "<option value=\"\" selected disabled hidden>- 지역구 -</option>";
   for(var data of disctList) {
      html += "<option value=\"" + data.DISCT_NO + "\">" + data.DISCT_NAME + "</option>";
   }
   
   $("#disct_gbn").html(html);
}

 function getDisctList(){
	 
	//select 지역구 option 불러오는 ajax
		$.ajax({
			url: "getAccbkDisctListAjax",
	        type: "post",
	        dataType: "json",
	        success: function(result) {
	           drawDisctList(result.disctList);
	        },
	        error: function(request, status, error) {
	           console.log("error");
	        }
		});
 }
//마켓 검색 결과
function drawMarketList(marketList) {
   var html = "";
   
   for(var data of marketList) {
      html += "<li market_no=\"" + data.MARKET_NO + "\">"
      html += "   <div class=\"marker\"></div><span>" + data.MARKET_NAME + "</span>"
      html += "</li>";
   }
   
   $("#market_list").html(html);
}

// 지점 검색 결과
function drawBranchList(branchList) {
   var html = "";
   
   for(var data of branchList) {
      html += "<li>"
      html += "   <div class=\"marker\"></div><span>" + data.BRANCH_NAME + "</span>"
      html += "</li>";
   }
   
   $("#branch_list").html(html);
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
	        <div class="accbkC_contnr">
				<form action="#" id="write_form" method="post">
				<!--품목, 구매량,금액, 비고 +버튼 누르면 추가할 수 있게.  -->
				구입 일자 <input type="date" id="buy_date" name="buy_date">
				<br> 
				구입처 
				<%-- <div id="buy_market">
					<c:set var="cnt" value="0"></c:set>
					<c:forEach var="data" items="${list}">
						<c:set var="cnt" value="${cnt+1}"></c:set>
				 		<input type="checkbox" name="market_no" class="market_no" value="${data.MARKET_NO}"><label>${data.MARKET_NAME}</label>
				 		 <!--  <input type="hidden" name="market_name"> -->
				 		<c:if test="${cnt%5==0}">
					 		<br>
					 	</c:if>
				 	</c:forEach>
					<input type="checkbox" name="market_no" class="market_no others" value=""><label>직접입력</label>
					<input type="text" id="market_name" name="market_name" disabled="disabled"><br>
				</div> --%>
				<div id="buy_market" class="buy_market">
					<input type="hidden" id="market_no" name="market_no">
					<div id="others_market_name_contnr" class="others_market_name_contnr">
						<!-- <span>마켓 이름 직접 입력 </span> -->
						<input type="text" id="market_name" name="market_name" class="market_name" placeholder="구입처 이름을 직접 입력해주세요">
					</div>
					
					<div id="search_market_contnr" class="search_market_contnr">
						<select id="disct_gbn" class="disct_gbn"></select><br>
						<input type="text" id="search_market_name" name="search_market_name">
						<input type="button" id="search_market_btn" class="search_market_btn" value="마켓 검색">
						<input type="button" id="others_market_btn" class="others_market_btn" value="직접 입력">
						
					</div>
					<div id="market_branch_name_contnr" class="market_branch_name_contnr">
						<ul id="market_list" class="market_list"></ul>
						<ul id="branch_list" class="branch_list"></ul>
						<input type="text" id="select_market_branch_name" class="select_market_branch_name" disabled="disabled">
					</div>
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
				<!--  <div id="buy_items_contnr">
					<input type="hidden" id="items_no" name="items_no">
					<div id="others_items_name_contnr" class="others_name_contnr">
						<input type="text" id="items_name" name="items_name" class="items_name" placeholder="품목을 직접 입력해주세요">
					</div>
					
					<div id="search_items_contnr" class="search_items_contnr">
						<input type="text" id="search_items_name" name="search_items_name" class="search_items_name">
						<input type="button" id="search_items_btn" class="search_items_btn" value="품목 검색"> 
					</div>
					
					<div id="items_name_contnr" class="items_name_contnr">
						<ul id="items_list" class="items_list"></ul>
						<input type="text" id="select_items_name" class="select_items_name" disabled="disabled">
					</div>
				</div>  -->
				
				<br>
				구매량
				<input type="text" id="buy_qnt" name="buy_qnt">	<br>
				금액
				<input type="text" id="cost" name="cost">원
				<br>
				비고 <input type="text" id="note" name="note"><br>
			
				<input type="button" value="작성" id="write_btn" class="accbkC_btn"> 
				<input type="button" value="취소" id="write_cancel_btn" class="accbkC_btn">
				</form>
			</div>
        </div>
    </div>
    <div class="bottom_contnr"></div>
</main>
</body>
</html>