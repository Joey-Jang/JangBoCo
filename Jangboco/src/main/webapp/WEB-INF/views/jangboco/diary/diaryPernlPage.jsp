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
<link rel="stylesheet" type="text/css" href="resources/css/join/diary.css">
<script type="text/javascript" src="resources/script/jquery/jquery-1.12.4.min.js"></script>
<script type="text/javascript" src="resources/script/jquery/jquery.form.js"></script>
<script type="text/javascript" src="resources/script/layout/default.js"></script>
<script type="text/javascript" src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=9a34fa20b8bdbafa1061701c69f892c1&libraries=services"></script>
<script type="text/javascript" src="resources/script/layout/addrsMapApi.js"></script>
<script>
var page = 1;

$(document).ready(function() {
   if("${param.searchGbn}" != "") {
      $("#searchGbn").val("${param.searchGbn}");
   }
   reloadList();

   $("#searchBtn").on("click", function() {
      $("#page").val("1");
      $("#oldTxt").val($("#searchTxt").val());
      reloadList();
   });
   
   $("#addBtn").on("click", function() {
      $("#searchTxt").val($("#oldTxt").val());
      $("#actionForm").attr("action","testAMAdd");
      $("#actionForm").submit();
   });
   
   $("#pagingWrap").on("click", "span", function() {
      $("#page").val($(this).attr("page"));
      reloadList();
   });
   

    
});

function diaryDtl(diary_no){
	alert(diary_no);
}

function reloadList() {
      var params = $("#actionForm").serialize(); //form의 데이터를 문자열로 변환
      $.ajax({ //jquery의 ajax함수 호출
         url: "diaryPernlListAjax", //접속 주소
         type: "post", //전송 방식
         dataType: "json", // 받아올 데이터 형태
         data: params, //보낼 데이터(문자열 형태)
         success: function(res){ // 성공(ajax통신 성공) 시 다음 함수 실행
            console.log(res);
            drawList(res.list);
            drawPaging(res.pb);
         },
         error: function(request, status, error) {//실패 시 다음 함수 실행
            console.log(error);
         }
      });
   }
   
function drawList(list){
   var html = "";

   for(var data of list){
	  html +=  "<div class=\"diary\">";
	  html += "<img src=\"resources/images/diaryImages/profile.png\" class=\"fill-img2\"></div>";
	 
   }
  
   
   
   $(".diary_list").html(html);
}

function drawPaging(pb) {
   var html = "";
   
   html += "<span page=\"1\">처음</span>       " ;
   
   if($("#page").val() == "1"){
      html += "<span page=\"1\">이전</span>       " ; 
   } else {
      html += "<span page=\"" + ($("#page").val() *1 - 1)+ "\">이전</span>       " ; 
   }
   
   for(var i = pb.startPcount; i<=pb.endPcount; i++){
      if($("#page").val() == i){
         html += "<span page=\"" + i + "\"><b>" + i + "</b></span>   " ;
      }else {
         html += "<span page=\"" + i + "\">" + i + "</span>   " ;
      }
   }
   
   if($("#page").val() == pb.maxPcount) {
      html += "<span page=\"" + pb.maxPcount + "\">다음</span>       " ; 
   }else {
      html += "<span page=\"" + ($("#page").val() *1 + 1)+ "\">다음</span>       " ;
   }
   
   html += "<span page=\"" + pb.maxPcount + "\">마지막</span>       " ;
   
   $("#pagingWrap").html(html);
      
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
         <div class="mypage_contnr">
            <div class="left_side_contr">
            	<div class="profile_list">
	            	<div class="profile_contr">
    	        		<div class="main_img">
        	    		</div>
            			<div class="folw_List">
            				<span onClick="f">팔로우</span>
            				<span>팔로워</span>
            			</div>
            		</div>
				   	<div class="do_folw">
            			<input type="button" value="팔로잉"/>
            		</div>
            	</div>

            </div>
            <div class="right_side_contr">
            	<div class="member_diary">
		            <form action="#" id="actionForm" method="post">
		               <input type="hidden" id="no" name="no" />
		               <input type="hidden" id="page" name="page" value="${page}" />
	                   <input type="hidden" id="page_member_no" name="page_member_no" value="${page_member_no}">
		            </form>
		            <div class="diary_list">
		            	<div class="diary">
		            		<img src="resources/images/diaryImages/profile.png" class="fill-img2" alt="프로필">
		            	</div>
		            	<div class="diary">
		            		<img src="resources/images/diaryImages/profile.png" class="fill-img2" alt="프로필">
		            	</div>
		            	<div class="diary">
		            		<img src="resources/images/diaryImages/profile.png" class="fill-img2" alt="프로필">
		            	</div>
		            	<div class="diary">
		            		<img src="resources/images/diaryImages/profile.png" class="fill-img2" alt="프로필">
		            	</div>
		            	<div class="diary">
		            		<img src="resources/images/diaryImages/profile.png" class="fill-img2" alt="프로필">
		            	</div>
		            	<div class="diary">
		            		<img src="resources/images/diaryImages/profile.png" class="fill-img2" alt="프로필">
		            	</div>
		            </div>
		            <div id="pagingWrap">
		            1234
	           		</div>
           		</div>	
            </div>
           </div>
       </div>
    </div>
    <div class="bottom_contnr"></div>
</main>
</body>
</html>