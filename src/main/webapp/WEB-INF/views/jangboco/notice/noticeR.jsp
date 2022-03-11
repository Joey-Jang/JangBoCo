<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공지사항 목록</title>
<link rel="preconnect" href="https://fonts.gstatic.com">
<link rel="stylesheet"
	href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100;300;400;500;700;900&display=swap">
<link rel="stylesheet" type="text/css"
	href="resources/css/layout/default.css">
<link rel="stylesheet" href="resources/css/notice/notice.css" type="text/css">
<script type="text/javascript"
	src="resources/script/jquery/jquery-1.12.4.min.js"></script>
<script type="text/javascript" src="resources/script/layout/default.js"></script>
<script type="text/javascript"
	src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script type="text/javascript"
	src="//dapi.kakao.com/v2/maps/sdk.js?appkey=9a34fa20b8bdbafa1061701c69f892c1&libraries=services"></script>
<script type="text/javascript"
	src="resources/script/layout/addrsMapApi.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	if("${param.search_gbn}" != "") {
		$("#search_gbn").val("${param.search_gbn}");
	}
	getNoticeList();
	
	//검색
	$("#search_btn").on("click",function(){
		//$("#save_text").val($("#search_text").val());
		$("#page").val("1");
		
		getNoticeList();
	});
	
	//dtl page로 이동
	 $("tbody,tfoot").on("click","#go_notice_dtl",function(){
		$("#notice_no").val($(this).attr("no"));
	    
			
		$("#action_form").attr("action", "noticeDtl");
		$("#action_form").submit();
		});
	
	//paging
	$("#paging_wrap").on("click","span", function(){
		$("#page").val($(this).attr("page"));
		
		getNoticeList();
	});
	
	//enter로 검색해도 비동기화 되게 
	$("#search_text").on("keypress", function(event){
		if(event.keyCode == 13) {
			$("#search_btn").click();
			return false;
		}
	});
	
});

function getNoticeList(){
	var params = $("#action_form").serialize();
	
	$.ajax({
		url :"noticePernlListAjax",
		type :"post",
		dataType :"json",
		data : params,
		success : function(result){
			drawNoticeList(result.list);
			drawNoticeBestList(result.bestList);
			drawPaging(result.pb);
		},
		error : function(request,status,error){
			console.log(error);
		}
	});
};
//공지 BEST3 불러오기 
function drawNoticeBestList(bestList){
	var html = "";
	
	for(var data of bestList){
		html+=	"<tr no=\""+data.NOTICE_NO+"\">  ";
		 html+=	"<td>"+data.NOTICE_NO +"</td> ";
		 html+=	"<td  no=\""+data.NOTICE_NO +"\" id=\"go_notice_dtl\" class=\"title\">"+data.TITLE +"</td> ";
		 html+=	"<td>"+data.REGST_DATE +"</td> ";
		 html+=	"<td>"+data.HIT_NUM +"</td> ";
		 html+= "</tr> ";
	}
	 $("#notice_tbl_body").html(html);
}

// 공지 목록 불러오기
function drawNoticeList(list){
	var html = "";
	
	 if(list.length == 0){
			
	    	html += "<tr>                                    ";
			html += "	<td colspan=\"8\">게시글이 없습니다.</td>	";            		
			html += "</tr>                                   ";
			
	} 
	
	for(var data of list){
		html+=	"<tr no=\""+data.NOTICE_NO+"\">  ";
		 html+=	"<td>"+data.NOTICE_NO +"</td> ";
		 html+=	"<td  no=\""+data.NOTICE_NO +"\" id=\"go_notice_dtl\" class=\"title\">"+data.TITLE +"</td> ";
		 html+=	"<td>"+data.REGST_DATE +"</td> ";
		 html+=	"<td>"+data.HIT_NUM +"</td> ";
		 html+= "</tr> ";
	}
	 $("#notice_tbl_foot").html(html);
}

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
				<div class="notice_pernl_r_wrap">
					<table id="notice_pernl_r">
						<thead>
							<tr>
								<th style="width:10%">공지번호</th>
								<th style="width:60%">제목</th>
								<th style="width:10%">등록일</th>
								<th style="width:10%">조회수</th>
							</tr>
						</thead>
						<tbody class="notice_tbl_body" id="notice_tbl_body"></tbody>
						<tfoot class="notice_tbl_foot" id="notice_tbl_foot"></tfoot>
					</table>
					<div class="search_form">
						<form action="#" id="action_form" method="post">
							<input type="hidden" name="page" id="page" value="${page}">
							<input type="hidden" name="noticeNo" id="notice_no">
							<div id="search_contnr">
								<select id="search_gbn" name="search_gbn">
									<option hidden="" disabled="disabled" selected="selected"
										value="">검색</option>
									<option value="title">제목</option>
									<option value="con">내용</option>
								</select> <input type="text" id="search_text" name="search_text"
									value="${param.search_text}" placeholder="검색어를 입력하세요">
								<button id="search_btn">
									<img class="btn_img"
										src="resources/images/intgrevent/search_button.svg">
								</button>
							</div>
						</form>
						<div id="paging_wrap" class="paging_wrap"></div>
					</div>
				</div>
			</div>
		</div>
		<div class="bottom_contnr"></div>
	</main>
</body>
</html>