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
		min-height: 820px;
		min-width: 1200px;
	}
	
	.con {
		display: flex;
	}
	.paging_wrap {
		display:flex;
		width : auto;
		/* height : 30px; */
		 justify-content: center;
		/* align-items: center;  */
		margin: auto;
		margin-top: 30px;
	}	
	
	.event_best td {
		background-color: #03A64A20;
				
	}
	
	.btn {
		background-color: #FFFFFF; 
	    cursor: pointer;
		border-width: 1px;
   		border-radius: 10px;		
	}
	
	.btn_img {
		width: 20px;
		filter: invert(44%) sepia(70%) saturate(381%) hue-rotate(103deg) brightness(88%) contrast(85%);
	}	
	
	
	#search_btn{
		background-color:transparent; 
	    cursor: pointer;
		border: none;
		position : absolute;
		left:208px;
		top:1px;	
	}	
	
	#search_box {
		position : relative;
		margin-right: 65px;
	}
	
	.back_btn_contnr{
		margin-right: 10px;
		padding-top:5px;
		width: 34px
	}
			
	.intgr_event_title {
		font-size : 25px;
	}
	
	.disct_choice{
		display: flex;
		flex-direction: row;
		align-content: center;
		margin-left: 60px;
	}
	
	.disct_choice span {
		display:inline-block;
		font-size : 20px;
		color: #038C3E;
		cursor: pointer;
	}
	
	.disct_choice div {
		display:none;
		height: 30px;		
		font-size : 20px;
		border : 3px solid #038C3E;
		margin-left: 5px;						
	}	
	
	.disct_search{
		display: flex;
		flex-direction: row;
		justify-content: space-between;
		margin-top:20px;
		margin-bottom:40px;		
	}	
	
	table{
		width:90%;
		min-height:360px;					
		margin:auto;
		text-align: center;
		border-collapse: collapse;
		table-layout:fixed;
	}
	
	thead{
		border-bottom: 2px solid #000000;	
	}	
	
	tbody tr, tfoot tr {
		border-bottom: 1px solid #D9B88F;
		height:4vh;
	}
	
	.event_name{
		text-overflow:ellipsis;
		overflow:hidden;
		white-space: nowrap; 
	}
	
	tobody .event_name:hover,tfoot .event_name:hover{
		cursor: pointer;
	}		
	
	.market_name{
		text-overflow:ellipsis;
		overflow:hidden;
		white-space: nowrap; 
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
	
	
</style>
<script type="text/javascript" src="resources/script/jquery/jquery-1.12.4.min.js"></script>
<script type="text/javascript" src="resources/script/layout/default.js"></script>
<script type="text/javascript" src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=9a34fa20b8bdbafa1061701c69f892c1&libraries=services"></script>
<script type="text/javascript" src="resources/script/layout/addrsMapApi.js"></script>
<script type="text/javascript">
$(document).ready(function(){			
	if($("#disct_no").val() == null || $("#disct_no").val() == ""){	
		var disctName = "";
		$('#main_loc_addrs').on('DOMSubtreeModified', function() { //주소스팬태그 값 변하면 동작
		      
		      // 주소-좌표 변환 객체를 생성합
		      var geocoder = new kakao.maps.services.Geocoder();
		      
		      // 주소로 좌표를 검색
		      geocoder.addressSearch($("#main_loc_addrs").text(), function(result, status) {
	
		          // 정상적으로 검색이 완료
		           if (status === kakao.maps.services.Status.OK) {
		              disctName = result[0].address.region_2depth_name; //주소로 구 정보 가져오기
		              console.log(disctName); 
						// 지역구 번호 없이 넘어오는 경우
						$("#disct_name_data").val(disctName);
						$("#disct_name").html(disctName + ">");
						console.log($("#disct_name_data").val());
						reloadList();
		              }
			});
		});		
	} else {
		reloadList();
	}
	
	if("${param.searchGbn}" != ""){
		$("#search_gbn").val("${param.searchGbn}");
	} 
	
	
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
	
	$("tbody,tfoot").on("click","#go_event_dtl",function(){
		$("#event_no").val($(this).attr("no"));
		
		$("#action_form").attr("action","intgrEventDtl");
		$("#action_form").submit();
	});
	
	$("#disct_name").on("click",function(){
		$(".disct_choice div").css("display","flex");		
	});
	
	$("#disct_choice").on("change",function(){
		$("#disct_no").val($(this).val());
		$("#disct_name_data").val($("#disct_choice option:checked").text());
		$("#disct_name").html($("#disct_choice option:checked").text() +">");
		$(".disct_choice div").css("display","none");
		reloadList();
	});
	
	$("#disct_choice").on("blur",function(){
		$(".disct_choice div").css("display","none");
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
		html += "    <td class=\"market_name\">"+ data.MARKET_NAME +"</td>       ";
		html += "    <td no=\""+data.EVENT_NO +"\" id=\"go_event_dtl\" class=\"event_name\">";
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
	
	if(normalList.length == 0){
		
    	html += "<tr>                                    ";
		html += "	<td colspan=\"8\">게시글이 없습니다.</td>	";            		
		html += "</tr>                                   ";
		
		$("table").css("min-height","auto");
	}
	
	for( var data of normalList){
		html += "<tr>        ";
		html += "    <td>"+ data.EVENT_NO +"</td>                   ";
		html += "    <td class=\"market_name\">"+ data.MARKET_NAME +"</td>       ";
		html += "    <td  no=\""+data.EVENT_NO +"\" id=\"go_event_dtl\" class=\"event_name\">";
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
        	<div class="back_btn_contnr">
	        	<button type="button" class="btn" id="back_btn">
		        	<img class="btn_img" src = "resources/images/intgrevent/back_button.svg">     	
				</button>        	
        	</div>
        	<div class="intgr_event_con">
	        	<div class="intgr_event_title">
		            지역구별 행사 소식
	        	</div>
	            <div class="disct_search">
	            	<div class="disct_choice">
	            		<span id="disct_name">${disctName} ></span>
	            		<div>
	            			<select id="disct_choice">
	            				<option hidden="" disabled="disabled" selected="selected" value="">지역 선택</option>
	            				<option value="380000">은평구</option>
	            				<option value="740000">강동구</option>
	            				<option value="710000">송파구</option>
	            				<option value="680000">강남구</option>
	            				<option value="650000">서초구</option>
	            				<option value="620000">관악구</option>
	            				<option value="590000">동작구</option>
	            				<option value="560000">영등포구</option>
	            				<option value="545000">금천구</option>
	            				<option value="530000">구로구</option>
	            				<option value="500000">강서구</option>
	            				<option value="470000">양천구</option>
	            				<option value="440000">마포구</option>
	            				<option value="410000">서대문구</option>
	            				<option value="350000">노원구</option>
	            				<option value="320000">도봉구</option>
	            				<option value="305000">강북구</option>
	            				<option value="260000">중랑구</option>
	            				<option value="230000">동대문구</option>
	            				<option value="215000">광진구</option>
	            				<option value="200000">성동구</option>
	            				<option value="170000">용산구</option>
	            				<option value="140000">중구</option>
	            				<option value="110000">종로구</option>
	            				<option value="290000">성북구</option>
	            			</select>
	            		</div>
	            	</div>
	            	<div class="search_form">
	            		<form action="#" id="action_form" method="post">
	            			<input type="hidden" id="save_text" value="${param.searchText}">
	            			<input type="hidden" name="page" id="page" value="${page}">
	            			<input type="hidden" name="eventNo" id="event_no">
	            			<input type="hidden" name="disctName" id="disct_name_data">	            			
	            			<input type="hidden" name="disctNo" id="disct_no" value="${disctNo}">	            			
	            			<div id="search_box">
		            			<select name=searchGbn id="search_gbn">
		            				<option hidden="" disabled="disabled" selected="selected" value="">검색</option>
		            				<option value="0">제목</option>
		            				<option value="1">마켓명</option>            				            				
		            			</select>
		            			<input type="text" name="searchText" id="search_text" value="${param.searchText}" placeholder="Search">
		            			<button type="button" id="search_btn">
		            				<img class="btn_img" src = "resources/images/intgrevent/search_button.svg">
								</button>	
	            			</div>
	            		</form>
	            	</div>
	            </div>
	            <div class="event_list_wrap">
		            <table>
		                <thead>
		                    <tr>
		                        <th style="width:5%">#</th>
		                        <th style="width:20%" class="market_name">행사매장</th>
		                        <th style="width:30%" class="event_name">행사제목</th>
		                        <th style="width:10%">등록일</th>
		                        <th style="width:9%">시작</th>
		                        <th style="width:9%">종료</th>
		                        <th style="width:5%">♥</th>
		                        <th style="width:7%">조회수</th>
		                    </tr>
		                </thead>
		                <tbody class="event_best">	                    	                             	                  
		                </tbody>
		            	<tfoot class="event_normal">            	
		            	</tfoot>     	
		            </table>	            
		        	<div class="paging_wrap">
		        	</div>		        	
	        	</div>
        	</div>
        </div>
    </div>
    <div class="bottom_contnr"></div>
</main>
</body>
</html>