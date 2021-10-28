<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>가계부-지출 내역 목록</title>
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
	if("${param.search_gbn}" != "") {
		$("#search_gbn").val("${param.search_gbn}");
	}
	getList();
	
	//지출 내역 추가 
	$("#write_btn").on("click", function(){
		$("#action_form").attr("action", "accbkC");
		$("#action_form").submit();
	});
	
	//검색
	$("#search_btn").on("click", function(){
		$("#page").val("1");
		getList();
	});
	
	//enter로 검색해도 비동기화 되게 
	$("#search_text").on("keypress", function(event){
		if(event.keyCode == 13) {
			$("#search_btn").click();
			return false;
		}
	});
	
	//삭제_체크박스_모두_체크
	 $( '.chkbx_all' ).click( function() {
          $( '.chkbx_pernl' ).prop( 'checked', this.checked );
        } );
	
	//삭제_버튼_누르면_체크박스,선택삭제_show
	$("#del_btn").on("click", function(){
		$('[name="del_chkbx"]').show();
		$("#select_del_btn").show();
		$("#del_cancel_btn").show();
		$("#del_btn").hide();
		
	}); 
	//취소_버튼_누르면_삭제버튼과_전부반대로
	$("#del_cancel_btn").on("click",function(){
		$('[name="del_chkbx"]').hide();
		$("#select_del_btn").hide();
		$("#del_cancel_btn").hide();
		$("#del_btn").show();
	});
	
	
	
	//삭제
	$("#select_del_btn").on("click", function(){
		var chkbxArr = new Array();
		//console.log($('input[name="del_chkbx"]:checked'));
		$('input[name="del_chkbx"]:checked').each(function(){
			//chkbxArr.push($('input[name="del_chkbx"]:checked').val());
			chkbxArr.push(this.value);
		});
		//console.log(chkbxArr);
		var chkbxCnt = chkbxArr.length;
		
		if (chkbxCnt == 0) {
			alert("삭제할 지출 내역을 선택해주세요");
		} else {
			
		 	//$.ajaxSettings.traditional = true; 
			$.ajax({
				url : "accbkDAjax",
				type : "post",
				dataType : "json",
				data : {"del_chkbx" : JSON.stringify(chkbxArr)},
				success : function(result){
					if (result.msg=="success") {
						alert("삭제 성공");
						getList();
						$('[name="del_chkbx"]').hide();
						$("#select_del_btn").hide();
						$("#del_cancel_btn").hide();
						$("#del_btn").show();
					} else if(result.msg=="failed") {
						alert("삭제 실패");
					} else{
						alert("삭제 중 문제 발생");
					}
				},
				error : function(request, status, error){
					console.log(error);
				}
				
			}); //ajax 끝
		}
		
	});
	
	$(".paging_wrap").on("click","span", function(){
		$("#page").val($(this).attr("page"));
		
		getList();
	});	
	
	
	
		
});// document.ready 끝

//데이터 취득
function getList(){
	var params = $("#action_form").serialize();
									// action_form의 data를 문자열로 가져 옴 
	
	$.ajax({
		url :"accbkRAjax",
		type :"post",
		dataType :"json",
		data : params,
		success : function(result){
			drawList(result.list);
			drawPaging(result.pb);
		},
		error : function(request,status,error){
			console.log(error);
		}
	}); //ajax 끝

}; //function getList 끝

//수정
$("#").on("click",function(){
	var currentRow = $(this).closest('tr');
	console.log(currentRow);
	var updateBtn = $(this);
	 
	var tr = updateBtn.parent().parent();
	var td = tr.children();
	
	console.log(updateBtn);
	console.log(tr.text());
	
	
	$(".update_btn").attr("action","accbkU");
	
});


// 수정
function updateList(pa){
	$("#update_no").val(pa);
	$("#move_update").attr("action", "accbkU");
	$("#move_update").submit();
	
	
}


function drawList(list){
	
	 var html = "";
	 
	 for(var data of list){
		 html+=	"<tr id=\""+data.ACCBK_NO+"\">  ";
		 html+=	"<td><input type=\"checkbox\" name=\"del_chkbx\"class=\"chkbx_pernl\" value=\""+data.ACCBK_NO+"\"></td> ";
		 html+=	"<td>"+data.MARKET_NAME +"</td> ";
		 html+=	"<td>"+data.ITEMS_NAME +"</td> ";
		 html+=	"<td>"+data.BUY_QNT +"</td> ";
		 html+=	"<td>"+data.COST +"</td> ";
		 html+=	"<td>"+data.NOTE +"</td> ";
		 html+=	"<td>"+data.BUY_DATE +"</td> ";
		 html+=	"<td id=\""+data.ACCBK_NO+"\"><input type=\"button\" class=\"update_btn\" id=\""+data.ACCBK_NO+"\" onclick=\"updateList("+data.ACCBK_NO+")\" value=\"수정\" ></td> ";
		 /*onclick 추가 function param은 tr:id  onclick =\""updateList(""+data.ACCBK_NO+"\")"  */
		 html+= "</tr> ";
	 }
		 $("tbody").html(html);
}

function drawPaging(pb){
	var html ="";
	
	html += "<span page=\"1\">처음</span> ";
	
	if ($("#page").val() =="1") {
		html += "<span=\"1\">이전</span>  ";
	}else{
		html += "<span=\"" + ($("#page").val()*1-1) + "\">이전</span>  ";
	}
	
	for (var i = pb.startPcount; i <= pb.endPcount; i++) {
		if ($("#page").val()== i) {
			html += "<span page=\""+ i + "\"><b>" + i + "</b></span>  ";
		} else {
			html += "<span page=\""+ i + "\">" + i + "</span>  ";
		}
	}
	
	if ($("#page").val() == pb.maxPcount) {
		html += "<span page = \"" + pb.maxPcount + "\" >다음</span>  ";
	} else {
		html += "<span=\"" + ($("#page").val() * 1 + 1) + "\">다음</span>  ";
	}
		html += "<span page = \"" + pb.maxPcount + "\">마지막</span>  ";
		
		$(".paging_wrap").html(html);
}	
</script>
</head>
<body>
<c:import url="/layoutTopLeft"></c:import>
<main>
	<form action="#" id="goForm" method="post">
      	<input type="hidden" name="member_no" value="${memberNo}">
		<input type="hidden" id="home_flag" name="home_flag" value="${param.home_flag}">
		<input type="hidden" id="menu_idx" name="menu_idx" value="${param.menu_idx}">
		<input type="hidden" id="sub_menu_idx" name="sub_menu_idx" value="${param.sub_menu_idx}">
	</form>
    <div class="con_contnr">
        <div class="con">
			<!--품목 & 구입처로 검색할 수 있게 하기.  -->
			<input type="button" id="write_btn" value="지출내역추가" >
			<div>
			<table >
				<thead>
				 	<tr>
				 		<th><input type="checkbox" name="del_chkbx" class="chkbx_all" ></th>
				 		<th>구입처</th>
				 		<th>품목</th>
				 		<th>구매량</th>
				 		<th>금액</th>
				 		<th>비고</th>
				 		<th>구입 일자</th>
				 		<th>수정</th>
				 	</tr>
				</thead>
				<tbody></tbody>
			</table>
			</div>
			<form action="#" id="move_update">
				<input type='hidden' id="update_no" name="update_no"/>
			</form>
			<input type="button" id="select_del_btn" value="선택 삭제">
			<input type="button" id="del_btn" value="삭제">
			<input type="button" id="del_cancel_btn" value="취소" >
			<br>
			<div>
			<form action="#" id="action_form" method="post">
				<input type="hidden" id="page" name="page" value="${page}">
				<select id="search_gbn" name="search_gbn">
					<option hidden="" disabled="disabled" selected="selected">검색</option>
					<option value="search_items">품목</option>
					<option value="search_buy_market">구입처</option>
				</select>
				<input type="text" id="search_text" name="search_text" value="${param.search_text}">
				<input type="button" id="search_btn" value="검색">
				
				
			</form>
			</div>
			<div class="paging_wrap"></div>
        </div>
    </div>
    <div class="bottom_contnr"></div>
</main>
</body>
</html>