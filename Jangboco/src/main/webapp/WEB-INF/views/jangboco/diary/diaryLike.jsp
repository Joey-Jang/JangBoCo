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
   reloadList();
   $("#pagingWrap").on("click", "span", function() {
      $("#page").val($(this).attr("page"));
      $("#searchTxt").val($("#oldTxt").val());
      reloadList();
   });
   
/*    $(".card").on("click", function() {
      $("#no").val($(this).attr("no"));
   });
 */   
   $(".card").on("click", function() {
	     alert("test");
	});
 
   
});

function diaryDtl(diary_no){
	$("#diary_no").val(diary_no);
	$("#prev_home_flag").val($("#home_flag").val());
	$("#prev_menu_idx").val($("#menu_idx").val());
	$("#prev_sub_menu_idx").val($("#sub_menu_idx").val());
	
	$("#dtlForm").submit();
}
function reloadList() {
      var params = $("#actionForm").serialize(); //form의 데이터를 문자열로 변환
      
      $.ajax({ //jquery의 ajax함수 호출
         url: "diaryLikeListAjax", //접속 주소
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
	  html += "<div class=\"card\" onClick=\"diaryDtl("+data.DIARY_NO+")\">";
      html += "<div class=\"card-header\">";
      html += "<div class=\"card-user\">";
      html += "<div class=\"card-user-profile\">";
      html += "<img class=\"full-img\" src=\"resources/images/diaryImages/profile.png\" alt=\"프로필\">";
      html += "</div>";
      html += "<p class=\"card-user-name\">"+data.NICNM+"</p>";
      html += "</div>";
      html += "<div class=\"card-like\">";
      html += "<img src=\"resources/images/diaryImages/heart.png\" alt=\"좋아요\">";
      if(data.LIKE_CNT != null){
          html += "<span>"+data.LIKE_CNT+"</span>";
       } else {
          html += "<span>0</span>";
       }
      html += "</div>";
      html += "</div>";
      html += "<div class=\"card-thumbnail\">";
      html += "<span class=\"card-thumbnail-views\">"+data.HIT_NUM+"</span>";
      if(data.IMG_URL!=null){
         	html += "<img class=\"full-img\" src=\"https://image.jangboco.ga/"+ data.IMG_URL.replace(/\[/g, "%5B").replace(/\]/g, "%5D") + "\" alt=\"썸네일\">";    	  
      } else {
        	html += "<img class=\"full-img\" src=\"resources/images/diaryImages/1.jpg\" alt=\"썸네일\">";
      }     html += "</div>";
      html += "<div class=\"card-contents\">"+data.CON+" </div>";
      html += "</div>";
   }
   
   
   $(".card-wrapper").html(html);
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
	<form action="#" id="go_form" method="post">
      <input type="hidden" id="home_flag" name="home_flag" value="${homeFlag}">
      <input type="hidden" id="menu_idx" name="menu_idx" value="${menuIdx}">
      <input type="hidden" id="sub_menu_idx" name="sub_menu_idx" value="${subMenuIdx}">
   </form>
    <div class="con_contnr">
        <div class="con">
            <form action="dtlDiary" id="dtlForm" method="post">
                <input type="hidden" id="diary_no" name="diary_no"/>
                <input type="hidden" id="prev_home_flag" name="home_flag">
				<input type="hidden" id="prev_menu_idx" name="menu_idx">
				<input type="hidden" id="prev_sub_menu_idx" name="sub_menu_idx">
            </form>
             <div class="container">
                <div class="header-container">
                  <h3>좋아요 보관함</h3>
                  <div class="header-container-nav">
                    <div class="header-search">
	                  <form action="#" id="actionForm" method="post">
	                     <input type="hidden" id="no" name="no" />
	                     <input type="hidden" id="page" name="page" value="${page}" />
	                     <input type="hidden" id="searchTxt" name="searchTxt" value="${param.searchTxt}" />
	                  </form>                    
                    </div>
                  </div>
                </div>
                <div class="card-wrapper">
                </div>
              </div>
            <div id="pagingWrap">
            </div>
       </div>
    </div>
    <div class="bottom_contnr"></div>
</main>
</body>
</html>