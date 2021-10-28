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
	.paging_wrap {
		display:flex;
		width : 100%;
		height : 30px;
		justify-content: space-between;
		align-items: center;
	}
	.event_best {
		background-color: lightgreen;		
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
	reloadList();
	
	$(".paging_wrap").on("click","span",function(){
		$("#page").val($(this).attr("page"));
		$("#search_text").val($("#save_text").val());
		
		reloadList();
	});
	
	$("#search_btn").on("click",function(){
		$("#save_text").val($("#search_text").val());
		$("#page").val("1");
		
		reloadList();
	});
	
	$("#search_text").on("keypress",function(event){
		if(event.keyCode == 13){
			$("#search_btn").click();
			return false;
		}
	});
	
	$("tbody").on("click","#go_event_dtl",function(){
		$("#event_no").val($(this).attr("no"));
		
		$("#action_form").attr("action","intgrEventDtl");
		$("#action_form").submit();
	});
});

// 데이터 취득
function reloadList(){
	var params = $("#action_form").serialize();
	
	$.ajax({ 
		url: "intgrEventListAjax", 
		type: "post", 
		dataType: "json", 
		data: params, 
		success : function(res) {
			drawBestList(res.bestList);
			drawNomalList(res.normalList);
			drawPaging(res.pb);
		},
		error: function(request, status, error) { 
			console.log(error);
		}
	});
};


// 행사 소식 목록(인기글)
function drawBestList(bestList){
	var html = "";
	for( var data of bestList){
		html += "<tr>        ";
		html += "    <td>"+ data.EVENT_NO +"</td>                   ";
		html += "    <td>"+ data.MARKET_NAME +"</td>       ";
		html += "    <td  no=\""+data.EVENT_NO +"\" id=\"go_event_dtl\">";
		html +=		 data.EVENT_NAME;
		html +=	"	 </td>	";
		html += "    <td>"+ data.REGST_DATE +"</td>            ";
		html += "    <td>"+ data.START_DATE +"</td>            ";
		html += "    <td>"+ data.END_DATE +"</td>            ";
		html += "    <td>"+ data.LIKE_CNT +"</td>                  ";
		html += "    <td>"+ data.HIT_NUM+"</td>                 ";
		html += "</tr>                            "		;
	}
	$(".event_best").html(html);	
}

// 행사소식 목록(일반)
function drawNomalList(normalList){
	var html = "";
	for( var data of normalList){
		html += "<tr>        ";
		html += "    <td>"+ data.EVENT_NO +"</td>                   ";
		html += "    <td>"+ data.MARKET_NAME +"</td>       ";
		html += "    <td  no=\""+data.EVENT_NO +"\" id=\"go_event_dtl\">";
		html +=		 data.EVENT_NAME;
		html +=	"	 </td>	";
		html += "    <td>"+ data.REGST_DATE +"</td>            ";
		html += "    <td>"+ data.START_DATE +"</td>            ";
		html += "    <td>"+ data.END_DATE +"</td>            ";
		html += "    <td>"+ data.LIKE_CNT +"</td>                  ";
		html += "    <td>"+ data.HIT_NUM+"</td>                 ";
		html += "</tr>                            "		;
	}
	$(".event_normal").html(html);	
}


// 페이징 출력
function drawPaging(pb){
	var html ="";
	
	html += "<div id=\"first_btn\">    "
	html += "	<span page=\"1\">처음</span>    "
	html += "</div>                  "
	html += "<div>                   "
	if($("#page").val()<=10){		
		html += "	<span page=\"1\">이전</span>    "
	} else {
		html += "	<span page=\"" +(pb.startPcount-1) + "\">이전</span>    "		
	}	
	html += "</div>                  "
	for(var i=pb.startPcount; i<=pb.endPcount; i++){		
		if($("#page").val()==i){
			html += "<div>                   "
			html += "	<span page=\""+ i + "\"><b>"+i+"</b></span>       "
			html += "</div>                  "			
		} else {
			html += "<div>                   "
			html += "	<span page=\""+ i + "\">"+i+"</span>       "
			html += "</div>                  "						
		}
	}
	
	if(pb.endPcount== pb.maxPcount){		
		html += "<div>                   "
		html += "	<span page=\""+pb.maxPcount +"\">다음</span>    "
		html += "</div>                  "
	} else {
		html += "<div>                   "
		html += "	<span page=\""+(pb.endPcount+1) +"\">다음</span>    "
		html += "</div>                  "		
	}
	html += "<div id=\"last_btn\">     "
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
      	<input type="hidden" name="member_no" value="${memberNo}">
		<input type="hidden" id="home_flag" name="home_flag" value="${homeFlag}">
		<input type="hidden" id="menu_idx" name="menu_idx" value="${menuIdx}">
		<input type="hidden" id="sub_menu_idx" name="sub_menu_idx" value="${subMenuIdx}">
	</form>
    <div class="con_contnr">
        <div class="con">
        	<div class="title_back">
	        	<button type="button" id="back_btn">뒤로가기</button>        	
	            <span>지역구별 행사 소식</span>
        	</div>
            <div class="disct_search">
            	<div class="disct_choice">
            		<span id="disct_name">지역구명</span>
            	</div>
            	<div class="search_form">
            		<form action="#" id="action_form" method="post">
            			<select name=searchGbn id="search_gbn">
            				<option hidden="" disabled="disabled" selected="selected" value="">검색</option>
            				<option value="0">제목</option>
            				<option value="1">마켓명</option>            				            				
            			</select>
            			<input type="text" name="searchText" id="search_text" value="${param.searchText}">
            			<input type="hidden" id="save_text" value="${param.searchText}">
            			<input type="hidden" name="page" id="page" value="${page}">
            			<input type="hidden" name="eventNo" id="event_no">
            			<button type="button" id="search_btn">검색</button>            			
            		</form>
            	</div>
            </div>
            <div class="event_list_wrap">
	            <table>
	                <thead>
	                    <tr>
	                        <th>#</th>
	                        <th>행사매장</th>
	                        <th>행사제목</th>
	                        <th>등록일</th>
	                        <th>시작</th>
	                        <th>종료</th>
	                        <th>♥</th>
	                        <th>조회수</th>
	                    </tr>
	                </thead>
	                <tbody class="event_best">	                    	                             	                  
	                </tbody>
	            </table>
	            <table>
	            	<tbody class="event_normal">	            	
	            	</tbody>
	            </table>
        	</div>
        	<div class="paging_wrap">        		
        	</div>        
        </div>
    </div>
    <div class="bottom_contnr"></div>
</main>
</body>
</html>