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
<!-- <script type="text/javascript" src="resources/script/layout/default.js"></script>
 --><script type="text/javascript" src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=9a34fa20b8bdbafa1061701c69f892c1&libraries=services"></script>
<script type="text/javascript" src="resources/script/layout/addrsMapApi.js"></script>
<script>
var page = 1;
var myMemberNo = <%=session.getAttribute("sMNo")%>;
var listFlag = 0;

$(document).ready(function() {
   
	
   $("#pagingWrap").on("click", "span", function() {
      $("#page").val($(this).attr("page"));
      reloadList();
   });
   
   $(".folwr").on("click",function(){
	   alert("팔로워");
   });
   
   reloadList();
   getMemberImg();
   getFolwFolwr();
   hideInit();
   checkFolw();
});

function diaryDtl(diary_no){
	alert(diary_no);
}

function getMemberImg(){
    $.ajax({ //jquery의 ajax함수 호출
        url: "getMemberImgAjax", //접속 주소
        type: "post", //전송 방식
        dataType: "json", // 받아올 데이터 형태
        data: {
        	"member_no" : $("#page_member_no").val()
        }, //보낼 데이터(문자열 형태)
        success: function(res){ // 성공(ajax통신 성공) 시 다음 함수 실행
           var html = "";
           if(res.IMG_URL!=null && res.IMG_URL != ""){
        	   html += "<img src=\"resources/upload/"+res.IMG_URL.replace(/\[/g, "%5B").replace(/\]/g, "%5D") + "\" class=\"profile_img\">";
           } else {
        	   html += "<img src=\"resources/images/diaryImages/user.png\" class=\"profile_img\">";
           }
           $(".main_img").html(html);
        },
        error: function(request, status, error) {//실패 시 다음 함수 실행
           console.log(error);
        }
     });
}

function getFolwr(){
	console.log("팔로워리스트 불러오기");
	//list flag 1
	listFlag = 1;
    $.ajax({ //jquery의 ajax함수 호출
        url: "getFolwrAjax", //접속 주소
        type: "post", //전송 방식
        dataType: "json", // 받아올 데이터 형태
        data: {
        	"member_no" : $("#page_member_no").val()
        }, //보낼 데이터(문자열 형태)
        success: function(res){ // 성공(ajax통신 성공) 시 다음 함수 실행
        	console.log(res);
           var html = "";
           html += "<div class=\"folw_list\">";
           for(var data of res.list){
			html += "<div class=\"folw_member\">";
			html += "<img src=\"resources/images/diaryImages/profile.png\" class=\"folw_img\" alt=\"프로필\">";
			html += "<div class=\"nicnm\">"+data.NICNM+"</div>";
			html += "</div>";
           }
           html+="</div>";
		   
           $(".member_diary").html(html);
		  
        },
        error: function(request, status, error) {//실패 시 다음 함수 실행
           console.log(error);
        }
     });
    
}


function getFolwng(){
	console.log("팔로잉리스트 불러오기");
	//list flag 2
	listFlag = 2;
    $.ajax({ //jquery의 ajax함수 호출
        url: "getFolwngAjax", //접속 주소
        type: "post", //전송 방식
        dataType: "json", // 받아올 데이터 형태
        data: {
        	"member_no" : $("#page_member_no").val()
        }, //보낼 데이터(문자열 형태)
        success: function(res){ // 성공(ajax통신 성공) 시 다음 함수 실행
        	console.log(res);
            var html = "";
            for(var data of res.list){
        		html += "<div class=\"folw_list\">";
 			html += "<div class=\"folw_member\">";
 			html += "<img src=\"resources/images/diaryImages/profile.png\" class=\"folw_img\" alt=\"프로필\">";
 			html += "<div class=\"nicnm\">"+data.NICNM+"</div>";
 			html += "</div></div>";
            }
            $(".member_diary").html(html);
 		  
        },
        error: function(request, status, error) {//실패 시 다음 함수 실행
           console.log(error);
        }
     });
}

function getFolwFolwr(){
    $.ajax({ //jquery의 ajax함수 호출
        url: "getFolwrFolwngAjax", //접속 주소
        type: "post", //전송 방식
        dataType: "json", // 받아올 데이터 형태
        data: {
        	"member_no" : $("#page_member_no").val()
        }, //보낼 데이터(문자열 형태)
        success: function(res){ // 성공(ajax통신 성공) 시 다음 함수 실행
           var html = "";
		          
           if(res.folw.FOLWR!=null && res.folw.FOLWR!=""){
      		   html += "<span class=\"folwr\" onClick=\"getFolwr();\">팔로워" + res.folw.FOLWR +"</span>";
           } else {
        	   html += "<span class=\"folwr\">팔로워0</span>";
           }
           
           if(res.folw.FOLWNG!=null && res.folw.FOLWNG!=""){
        	   html += "<span class=\"folwng\" onClick=\"getFolwng();\">팔로잉" + res.folw.FOLWNG +"</span>";
        	   
           } else {
        	   html += "<span class=\"folwng\">팔로잉0</span>";
           }
           
           $(".folw_List").html(html);
        },
        error: function(request, status, error) {//실패 시 다음 함수 실행
           console.log(error);
        }
     });
}

function hideInit(){
	//마이멤버 null이거나 ""거나 myMemberNo = pageMemberNo면 hide
	if(myMemberNo==null||myMemberNo==""||$("#page_member_no").val()==myMemberNo){
		$(".do_folw").css("display","none");
	}
	
}

function checkFolw(){
	//팔로우인지 팔로잉인지 확인하는것
    $.ajax({ //jquery의 ajax함수 호출
        url: "checkFolwAjax", //접속 주소
        type: "post", //전송 방식
        dataType: "json", // 받아올 데이터 형태
        data: {
        	"page_member_no":$("#page_member_no").val()
        }, //보낼 데이터(문자열 형태)
        success: function(res){ // 성공(ajax통신 성공) 시 다음 함수 실행
           console.log(res);
           if(res.result > 0){
        	   $("#doFolw").val("팔로잉");
           } else {
        	   $("#doFolw").val("팔로우");
           }
        },
        error: function(request, status, error) {//실패 시 다음 함수 실행
           console.log(error);
        }
     });
}

function doFolwUnFolw(){
	alert("Test");
	var flag = "";
	if($("#doFolw").val()=="팔로잉"){
	//unfolw	
		flag = "unfolw";
	} else if ($("#doFolw").val()=="팔로우"){
	//folw
		flag = "folw";
	}
	
    $.ajax({ //jquery의 ajax함수 호출
        url: "doFolwUnFolwAjax", //접속 주소
        type: "post", //전송 방식
        dataType: "json", // 받아올 데이터 형태
        data: {
        	"page_member_no":$("#page_member_no").val(),
        	"flag":flag
        }, //보낼 데이터(문자열 형태)
        success: function(res){ // 성공(ajax통신 성공) 시 다음 함수 실행
            checkFolw();
            getFolwFolwr();
            if(listFlag==1){
            	getFolwr();
            } else if(listFlag==2) {
            	getFolwng();
            }
        },
        error: function(request, status, error) {//실패 시 다음 함수 실행
           console.log(error);
        }
     });
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
	  if(data.IMG_URL!=null){
		  html += "<img src=\"resources/upload/"+ data.IMG_URL.replace(/\[/g, "%5B").replace(/\]/g, "%5D") + "\" class=\"fill-img2\"></div>";
	  } else {
		  html += "<img src=\"resources/images/diaryImages/profile.png\" class=\"fill-img2\"></div>";
	  }
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
    	        			<img src="" class="profile_img">
        	    		</div>
            			<div class="folw_List">
            				<span class="folwr" >팔로잉</span>
            				<span class="folwng">팔로워</span>
            			</div>
            		</div>
				   	<div class="do_folw">
					   	<input type="button" id="doFolw" class="doFolw" onClick="doFolwUnFolw()" value=""/>
            		</div>
            	</div>

            </div>
            <div class="right_side_contr">
            		  <form action="#" id="actionForm" method="post">
		               <input type="hidden" id="no" name="no" />
		               <input type="hidden" id="page" name="page" value="${page}" />
	                   <input type="hidden" id="page_member_no" name="page_member_no" value="${page_member_no}">
		            </form>
            	<div class="member_diary" >
            		<div class="folw_list" style="display:none;">      			
            		</div>
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