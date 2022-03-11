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
   var emailValidate = false;
   var authResult = false;

   $("#send_btn").attr("disabled",true);
   $("#auth_num").attr("disabled",true);
   $("#auth_btn").attr("disabled",true);
   
   $("#cancel_btn").on("click",function(){
      history.back();
   });
   
   $("#find_btn").on("click",function(){
      if(checkVal("#email")){
          alert("이메일을 입력해주세요");
          $("#email").focus();
       } else if (checkVal("#auth_num")){
         alert("비밀번호를 입력해주세요");
         $("#auth_num").focus();
      }  else {
         $.ajax({
             type:"POST",
             url: "findPwAjax",
             dataType:"json",
             data: {"email":$("#email").val()
            	   },
             success: function(res){
            	alert("test");
            	console.log(res);
            	if(res.cnt== 0){
            		alert("해당하는 메일이 없습니다");
            	} else if (res.cnt > 0) {
      			  $("#email").attr("disabled",false);
      			  $("#find_form").submit();
            	}
             }, 
             error: function(error){
                console.log(error);
             }
          });
      }
   });
   
   $("#email").on('keyup',function(event){
       if(!eCheck.test($("#email").val())){
          emailValidate = false;
          $("#email_warn").text("유효한 이메일 주소를 입력해주세요");
          $("#email_warn").css("color","red");
          $("#send_btn").attr("disabled",true);
       } else {
          emailValidate = true;
          $("#email_warn").text("");
          $("#send_btn").attr("disabled",false);
       }       
    });
   
   $("#send_btn").on("click",function(){
	      if(checkVal("#email")){
	          alert("이메일을 입력해주세요");
	          $("#email").focus();
	       } else {
	         var email = $("#email").val();
	         
	         $.ajax({
	            type:"GET",
	            url:"mailCheck?email="+email,
	            success: function(data){
	               emailNum = data;
	               $("#auth_num").attr("disabled",false);
	               $("#auth_btn").attr("disabled",false);
	            },
	            error: function(error){
	               console.log("error");
	            }
	         });
	       }
	   });
   
   $("#auth_btn").on("click",function(){
	  if(checkVal("#auth_num")){
		  alert("인증번호를 입력해주세요");
		  $("#auth_num").focus();
	  } else {
		  if($("#auth_num").val()==emailNum){
			  alert("인증성공");
			  authResult = true;
			  $("#email").attr("disabled",true);
              $("#send_btn").attr("disabled",true);
			  
		  } else {
			  alert("인증실패");
			  authResult = false;
		  }
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
	<form action="#" id="go_form" method="post">
      <input type="hidden" id="home_flag" name="home_flag" value="${homeFlag}">
      <input type="hidden" id="menu_idx" name="menu_idx" value="${menuIdx}">
      <input type="hidden" id="sub_menu_idx" name="sub_menu_idx" value="${subMenuIdx}">
   </form>
    <div class="con_contnr">
        <div class="find_con">
           <div class="find_form_header">
              비밀번호찾기
           </div>
           <div class="find_form_body">
              <div class="find_form">
                 <form action="findMember" id="find_form" method="post">
                      <div class="form_input" >
                         <div class="form_input_text">
                            이메일  <span id="email_warn"></span>
                         </div>
                         <div class="find_email_input">
                            <div class="form_input_val">
                               <input type="email" id="email" name="email"/>
                            </div>
                            <div class="send_btn">
	                            <input type="button" id="send_btn" value="전송"/>
	                         </div>     
                         </div>                    
                      </div>
                      <div class="form_input">
                         <div class="form_input_text">
                            인증번호
                         </div>
                         <div class="find_email_input">
	                         <div class="form_input_val">
	                            <input id="auth_num" name="auth_num"/>
	                         </div>
	                         <div class="auth_btn">
	                            <input type="button" id="auth_btn" value="확인"/>
	                         </div>                       
		                 </div>
		                 </div>
                 </form>
                 <div class="find_btn">
                    <input type="button" value="확인" id="find_btn">
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