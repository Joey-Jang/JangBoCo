<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>QnA 목록</title>
<link rel="preconnect" href="https://fonts.gstatic.com">
<link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100;300;400;500;700;900&display=swap">
<link rel="stylesheet" type="text/css" href="resources/css/layout/default.css">
<link rel="stylesheet" type="text/css" href="resources/css/qna/qnaR.css">
<script type="text/javascript" src="resources/script/jquery/jquery-1.12.4.min.js"></script>
<script type="text/javascript" src="resources/script/layout/default.js"></script>
<script type="text/javascript" src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=9a34fa20b8bdbafa1061701c69f892c1&libraries=services"></script>
<script type="text/javascript" src="resources/script/layout/addrsMapApi.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	//list 불러오기
	getQnaList();

	//qna추가 
	$("#write_btn").on("click", function(){
		$("#action_form").attr("action", "qnaC");
		$("#action_form").submit();
	});
	
	//검색
	$("#search_btn").on("click", function(){
		$("#page").val("1");
		getQnaList();
	});
	
	//enter로 검색해도 비동기화 되게 
	$("#search_text").on("keypress", function(event){
		if(event.keyCode == 13) {
			$("#search_btn").click();
			return false;
		}
	});
	
	//paging
	$("#paging_wrap").on("click","span", function(){
		$("#page").val($(this).attr("page"));
		
		getQnaList();
	});	
});

//데이터취득
function getQnaList(){
	var params = $("#action_form").serialize();
	
	$.ajax({
		url :"QnaListAjax",
		type :"post",
		dataType :"json",
		data : params,
		success : function(result){
			drawQnaList(result.list);
			drawPaging(result.pb);
		},
		error : function(request,status,error){
			console.log(error);
		}
	}); //ajax 끝
}


function drawQnaList(list){
	var html = "";
	
	for(var data of list){
		html+=	"<tr id=\""+data.QNA_NO+"\">  ";
		 html+=	"<td>"+data.QNA_NO +"</td> ";
		 html+=	"<td>"+data.TITLE +"</td> ";
		 html+=	"<td>"+data.REGST_DATE +"</td> ";
		 html+=	"<td>"+data.HIT_NUM +"</td> ";
		 html+= "</tr> ";
	}
	 $("tbody").html(html);
}
function drawPaging(pb){
	var html ="";
	
	html += "<span page=\"1\">처음</span> ";
	
	if ($("#page").val() =="1") {
		html += "<span page=\"1\">이전</span>  ";
	}else{
		html += "<span page=\"" + ($("#page").val()*1-1) + "\">이전</span>  ";
	}
	
	for (var i = pb.startPcount; i <= pb.endPcount; i++) {
		if ($("#page").val()== i) {
			html += "<span page=\""+ i + "\"><b>" + i + "</b></span>  ";
		} else {
			html += "<span page=\""+ i + "\">" + i + "</span>  ";
		}
	}
	
	if ($("#page").val() == pb.maxPcount) {
		html += "<span page= \"" + pb.maxPcount + "\" >다음</span>  ";
	} else {
		html += "<span page=\"" + ($("#page").val() * 1 + 1) + "\">다음</span>  ";
	}
		html += "<span page= \"" + pb.maxPcount + "\">마지막</span>  ";
		
		$("#paging_wrap").html(html);
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
        <input type="button" id="write_btn" value="문의하기">
	        <div id="qna_list_wrap">
	        	<table id="qna_tbl">
	        		<thead>
		        		<tr>
		        			<th>문의번호</th>
		        			<th>제목</th>
		        			<th>등록일</th>
		        			<th>조회수</th>
		        		</tr>
	        		</thead>
	        		<tbody></tbody>
	        	</table>
	        </div>
	        
	        <form action="#" id="action_form" method="post">
	        	<input type="hidden" id="page" name="page" value="${page}">
	        	<select id="search_gbn" name="search_gbn">
	        		<option hidden="" disabled="disabled" selected="selected">-검색-</option>
	        		<option value="title">제목</option>
	        		<option value="con">내용</option>
	        	</select>
	        	<input type="text" id="search_text" name="search_text" value="${param.search_text}">
				<input type="button" id="search_btn" value="검색">
	        </form>
        </div>
        <div id="paging_wrap" class="paging_wrap"></div>
   </div>
 <div class="bottom_contnr"></div>
</main>
</body>
</html>