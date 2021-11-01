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
<link rel="stylesheet" href="//code.jquery.com/ui/1.13.0/themes/base/jquery-ui.css">
<script type="text/javascript" src="resources/script/jquery/jquery-1.12.4.min.js"></script>
<script type="text/javascript" src="resources/script/jquery/jquery.form.js"></script>
<script type="text/javascript" src="resources/script/layout/default.js"></script>
<script type="text/javascript" src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=9a34fa20b8bdbafa1061701c69f892c1&libraries=services"></script>
<script type="text/javascript" src="resources/script/layout/addrsMapApi.js"></script>
<script src="https://code.jquery.com/ui/1.13.0/jquery-ui.js"></script>
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
      $("#searchTxt").val($("#oldTxt").val());
      reloadList();
   });
   
   $(".card").on("click", function() {
	     alert("test");
	});
   
/*    $("#searchTxt").autocomplete({
       source: [ "감자", "고구마", "배추" ],
   });
 */
   
   $("#searchTxt").on("keyup",function(){
	      $.ajax({ //jquery의 ajax함수 호출
	          url: "hastgListAjax", //접속 주소
	          type: "post", //전송 방식
	          dataType: "json",
	          data: // 받아올 데이터 형태
	        	  {"searchTxt":$("#searchTxt").val(),
	          }, //보낼 데이터(문자열 형태)
	          success: function(res){ // 성공(ajax통신 성공) 시 다음 함수 실행
	        	  $("#searchTxt").autocomplete({
	        	       source: hastgToArray(res.list)
	        	   });
	          },
	          error: function(request, status, error) {//실패 시 다음 함수 실행
	             console.log(error);
	          }
	       });
   });
});

function hastgToArray(list){
	var arr = [];
	for ( data of list){
		arr.push(data.HASTG_NAME);
	}
	return arr;
}

function diaryDtl(diary_no){
	alert(diary_no);
}

function reloadList() {
      var params = $("#actionForm").serialize(); //form의 데이터를 문자열로 변환
      
      $.ajax({ //jquery의 ajax함수 호출
         url: "diaryListAjax", //접속 주소
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
      html += "<img class=\"full-img\" src=\"resources/images/diaryImages/1.jpg\" alt=\"썸네일\">";
      html += "</div>";
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
	<form action="#" id="goForm" method="post">
      	<input type="hidden" name="member_no" value="${memberNo}">
		<input type="hidden" id="home_flag" name="home_flag" value="${param.home_flag}">
		<input type="hidden" id="menu_idx" name="menu_idx" value="${param.menu_idx}">
		<input type="hidden" id="sub_menu_idx" name="sub_menu_idx" value="${param.sub_menu_idx}">
	</form>
    <div class="con_contnr">
        <div class="con">
         <div class="diary_contnr">
<%--             <form action="#" id="actionForm" method="post">
               <input type="hidden" id="no" name="no" />
               <input type="hidden" id="page" name="page" value="${page}" />
               <input type="text" id="searchTxt" name="searchTxt" value="${param.searchTxt}" />
               <input type="hidden" id="oldTxt" value="${param.searchTxt}" />
               <input type="button" id="searchBtn" value="검색" />
               <input type="button" id="addBtn" value="등록" />
            </form> --%>
             <div class="container">
                <div class="header-container">
                  <h3>장보코_다이어리</h3>
                  <div class="header-container-nav">
                    <div class="header-search">
	                  <form action="#" id="actionForm" method="post">
	                     <input type="hidden" id="no" name="no" />
	                     <input type="hidden" id="page" name="page" value="${page}" />
	                     <input type="text" id="searchTxt" name="searchTxt" value="${param.searchTxt}" />
	                     <input type="button" id="searchBtn" value="검색" />
	                  </form>                    
                    </div>
                    <a href="#" class="write-button">
                      <div class="plus-icon">
                        <span></span>
                        <span></span>  
                      </div>
                    </a>
                    <a href="#" class="mypage-button">
                      <img src="resources/images/diaryImages/profile.png" alt="마이페이지 바로가기">
                    </a>
                  </div>
                </div>
                <div class="card-wrapper">
                  <div class="card">
                    <div class="card-header">
                      <div class="card-user">
                        <div class="card-user-profile">
                          <img src="resources/images/diaryImages/profile.png" class="fill-img" alt="프로필">
                        </div>
                        <p class="card-user-name">오픈더캐비닛</p>
                      </div>
                      <div class="card-like">
                        <img src="resources/images/diaryImages/heart.png" alt="좋아요">
                        <span>2</span>
                      </div>
                    </div>
                    <div class="card-thumbnail">
                      <span class="card-thumbnail-views">조회수 120</span>
                      <img class="fill-img" src="resources/images/diaryImages/1.jpg" alt="썸네일">
                    </div>
                    <div class="card-contents">
                      온더 테이블 모음 🔥 파스타와 오픈샌드위치 ✨
                    </div>
                  </div>
                  <div class="card">
                    <div class="card-header">
                      <div class="card-user">
                        <div class="card-user-profile">
                          <img src="resources/images/diaryImages/profile.png" class="fill-img" alt="프로필">
                        </div>
                        <p class="card-user-name">오픈더캐비닛</p>
                      </div>
                      <div class="card-like">
                        <img src="resources/images/diaryImages/heart.png" alt="좋아요">
                        <span>2</span>
                      </div>
                    </div>
                    <div class="card-thumbnail">
                      <span class="card-thumbnail-views">조회수 120</span>
                      <img class="fill-img" src="resources/images/diaryImages/2.jpg" alt="썸네일">
                    </div>
                    <div class="card-contents">
                      온더 테이블 모음 🔥 파스타와 오픈샌드위치 ✨
                    </div>
                  </div>
                  <div class="card">
                    <div class="card-header">
                      <div class="card-user">
                        <div class="card-user-profile">
                          <img src="resources/images/diaryImages/profile.png" class="fill-img" alt="프로필">
                        </div>
                        <p class="card-user-name">오픈더캐비닛</p>
                      </div>
                      <div class="card-like">
                        <img src="resources/images/diaryImages/heart.png" alt="좋아요">
                        <span>2</span>
                      </div>
                    </div>
                    <div class="card-thumbnail">
                      <span class="card-thumbnail-views">조회수 120</span>
                      <img class="fill-img" src="resources/images/diaryImages/3.jpg" alt="썸네일">
                    </div>
                    <div class="card-contents">
                      온더 테이블 모음 🔥 파스타와 오픈샌드위치 ✨
                    </div>
                  </div>
                  <div class="card">
                    <div class="card-header">
                      <div class="card-user">
                        <div class="card-user-profile">
                          <img src="resources/images/diaryImages/profile.png" class="fill-img" alt="프로필">
                        </div>
                        <p class="card-user-name">오픈더캐비닛</p>
                      </div>
                      <div class="card-like">
                        <img src="resources/images/diaryImages/heart.png" alt="좋아요">
                        <span>2</span>
                      </div>
                    </div>
                    <div class="card-thumbnail">
                      <span class="card-thumbnail-views">조회수 120</span>
                      <img class="fill-img" src="resources/images/diaryImages/1.jpg" alt="썸네일">
                    </div>
                    <div class="card-contents">
                      온더 테이블 모음 🔥 파스타와 오픈샌드위치 ✨
                    </div>
                  </div>
                  <div class="card">
                    <div class="card-header">
                      <div class="card-user">
                        <div class="card-user-profile">
                          <img src="resources/images/diaryImages/profile.png" class="fill-img" alt="프로필">
                        </div>
                        <p class="card-user-name">오픈더캐비닛</p>
                      </div>
                      <div class="card-like">
                        <img src="resources/images/diaryImages/heart.png" alt="좋아요">
                        <span>2</span>
                      </div>
                    </div>
                    <div class="card-thumbnail">
                      <span class="card-thumbnail-views">조회수 120</span>
                      <img class="fill-img" src="resources/images/diaryImages/2.jpg" alt="썸네일">
                    </div>
                    <div class="card-contents">
                      온더 테이블 모음 🔥 파스타와 오픈샌드위치 ✨
                    </div>
                  </div>
                  <div class="card">
                    <div class="card-header">
                      <div class="card-user">
                        <div class="card-user-profile">
                          <img src="resources/images/diaryImages/profile.png" class="fill-img" alt="프로필">
                        </div>
                        <p class="card-user-name">오픈더캐비닛</p>
                      </div>
                      <div class="card-like">
                        <img src="resources/images/diaryImages/heart.png" alt="좋아요">
                        <span>2</span>
                      </div>
                    </div>
                    <div class="card-thumbnail">
                      <span class="card-thumbnail-views">조회수 120</span>
                      <img class="fill-img" src="resources/images/diaryImages/3.jpg" alt="썸네일">
                    </div>
                    <div class="card-contents">
                      온더 테이블 모음 🔥 파스타와 오픈샌드위치 ✨
                    </div>
                  </div>
                  <div class="card">
                    <div class="card-header">
                      <div class="card-user">
                        <div class="card-user-profile">
                          <img src="resources/images/diaryImages/profile.png" class="fill-img" alt="프로필">
                        </div>
                        <p class="card-user-name">오픈더캐비닛</p>
                      </div>
                      <div class="card-like">
                        <img src="resources/images/diaryImages/heart.png" alt="좋아요">
                        <span>2</span>
                      </div>
                    </div>
                    <div class="card-thumbnail">
                      <span class="card-thumbnail-views">조회수 120</span>
                      <img class="fill-img" src="resources/images/diaryImages/1.jpg" alt="썸네일">
                    </div>
                    <div class="card-contents">
                      온더 테이블 모음 🔥 파스타와 오픈샌드위치 ✨
                    </div>
                  </div>
                  <div class="card">
                    <div class="card-header">
                      <div class="card-user">
                        <div class="card-user-profile">
                          <img class="fill-img" src="resources/images/diaryImages/profile.png" alt="프로필">
                        </div>
                        <p class="card-user-name">오픈더캐비닛</p>
                      </div>
                      <div class="card-like">
                        <img src="resources/images/diaryImages/heart.png" alt="좋아요">
                        <span>2</span>
                      </div>
                    </div>
                    <div class="card-thumbnail">
                      <span class="card-thumbnail-views">조회수 120</span>
                      <img class="fill-img" src="resources/images/diaryImages/2.jpg" alt="썸네일">
                    </div>
                    <div class="card-contents">
                      온더 테이블 모음 🔥 파스타와 오픈샌드위치 ✨
                    </div>
                  </div>
                </div>
              </div>
            <div id="pagingWrap">
            </div>
           </div>
       </div>
    </div>
    <div class="bottom_contnr"></div>
</main>
</body>
</html>