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
<link rel="stylesheet" type="text/css" href="resources/css/join/join.css">
<script type="text/javascript" src="resources/script/jquery/jquery-1.12.4.min.js"></script>
<script type="text/javascript" src="resources/script/jquery/jquery.form.js"></script>
<script type="text/javascript" src="resources/script/layout/default.js"></script>
<script type="text/javascript" src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=9a34fa20b8bdbafa1061701c69f892c1&libraries=services"></script>
<script type="text/javascript" src="resources/script/layout/addrsMapApi.js"></script>
<script type="text/javascript">

$(document).ready(function(){

   var emailNum;
   var emailFlag = false;
   var eCheck=/^[_a-zA-Z0-9]+([-+.][_a-zA-Z0-9]+)*@([0-9a-zA-Z_-]+)(\.[0-9a-zA-Z_-]+){1,2}$/i;
 

   
   $("#cancel_btn").on("click",function(){
      history.back();
   });
   
   $("#login_btn").on("click",function(){
      if(checkVal("#email")){
          alert("이메일을 입력해주세요");
          $("#email").focus();
       } else if (checkVal("#pw")){
         alert("비밀번호를 입력해주세요");
         $("#pw").focus();
      }  else {
         $.ajax({
             type:"POST",
             url: "loginCheck",
             dataType:"json",
             data: {"email":$("#email").val(),
            	 	"pw":$("#pw").val()
            	   },
             success: function(res){
            	 console.log(res);
                if(res.cnt==0||res.cnt==""||res.cnt==null){
                   alert("해당하는 회원정보가 없습니다")
                } else {
                   alert("로그인성공!");
                   $("#member_type").val(res.member_type);
                   $("#login_form").submit();
                } 
             }, 
             error: function(error){
                console.log(error);
             }
          });
      }
   });
   
});



function checkVal(sel) {
   if($.trim($(sel).val()) == "") {
      return true;
   } else {
      return false;
   }
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
        <div class="login_con">
           <div class="login_form_header">
              일반로그인
           </div>
           <div class="login_form_body">
              <div class="login_form">
                 <form action="loginMember" id="login_form" method="post">
                      <div class="form_input" >
                         <div class="form_input_text">
                            이메일
                         </div>
                         <div class="login_email_input">
                            <div class="form_input_val">
                               <input type="email" id="email" name="email"/>
                            </div>
                         </div>                    
                      </div>
                      <div class="form_input">
                         <div class="form_input_text">
                            비밀번호
                         </div>
                         <div class="form_input_val">
                            <input id="pw" name="pw"/>
                         </div>                    
                      </div>
                      <div class="form_input_val">
                      	<input type="hidden" id="member_type" name="member_type">
                      </div>
                 </form>
                 <div class="loginBtn">
                    <input type="button" value="로그인" id="login_btn">
                    <input type="button" value="취소" id="cancel_btn">
                 </div>
              </div>
           </div>
        </div>
    </div>
    <div class="bottom_contnr"></div>
</main>
</body>
</html>