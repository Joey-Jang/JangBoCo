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
<!-- <script type="text/javascript" src="resources/script/jquery/jquery.form.js"></script>
 --><script type="text/javascript" src="resources/script/layout/default.js"></script>
<script type="text/javascript" src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=9a34fa20b8bdbafa1061701c69f892c1&libraries=services"></script>
<script type="text/javascript" src="resources/script/layout/addrsMapApi.js"></script>
<script type="text/javascript">

$(document).ready(function(){

   var emailNum;
   var emailFlag = false;
   var eCheck=/^[_a-zA-Z0-9]+([-+.][_a-zA-Z0-9]+)*@([0-9a-zA-Z_-]+)(\.[0-9a-zA-Z_-]+){1,2}$/i;
   
   $("#email_check_btn").on("click",function(){
      if(checkVal("#email")){
          alert("이메일을 입력해주세요");
          $("#email").focus();
       } else {
         var email = $("#email").val();
         $("#email_check_input").removeClass("hidden");
         
         $.ajax({
            type:"GET",
            url:"mailCheck?email="+email,
            success: function(data){
               emailNum = data;
            },
            error: function(error){
               console.log("error");
            }
         });
       }
   });
   
   $("#email_re_check_btn").on("click",function(){
      if($("#email_re_check").val()==emailNum){
         alert("인증번호가 일치합니다");
         emailFlag = true;
         $("#email").attr("disabled",true);
         $("#email_check_btn").attr("disabled",true);
         $("#email_re_check").attr("disabled",true);
         $("#email_re_check_btn").attr("disabled",true);
      } else {
         alert("인증번호가 틀렸습니다");
         emailFlag = false;
      }
   });
   
   $("#cancel_btn").on("click",function(){
      history.back();
   });
   
   $("#join_btn").on("click",function(){
      if(checkVal("#name")){
         alert("이름을 입력해주세요");
         $("#name").focus();
       } else if (checkVal("#nicnm")){
         alert("닉네임을 입력해주세요");
         $("#nicnm").focus();
       } else if (checkVal("#email")){
          alert("이메일을 입력해주세요");
          $("#email").focus();
       } else if (checkVal("#pw")){
         alert("비밀번호를 입력해주세요");
         $("#pw").focus();
      } else if (checkVal("#pw_check")){
         alert("비밀번호 확인란을 입력해주세요");
         $("#pw_check").focus();
      } else if ($("#pw").val() != $("#pw_check").val()){
         alert("비밀번호 확인이 일치하지 않습니다");
      } else if (emailFlag==false){
         alert("인증번호를 확인해주세요");
      } else if ($("#agrnt_box").prop("checked") == false){
         alert("약관동의를 확인해주세요");
      } else if (checkVal("#zipcds")){
         alert("우편번호를 입력해주세요");
         $("#zipcds").focus();
      } else if (checkVal("#addrs_other")){
         alert("주소를 입력해주세요");
         $("#addrs_other").focus();
      } else {
         alert("가입완료!");
         $("#join_form").submit();
      }
   });
   
   $("#zipcd_btn").on("click",function(){
       new daum.Postcode({
           oncomplete: function(data) {
              $("#zipcds").val(data['zonecode']);
               $("#addrs_other").val(data['address']);
               toDisabled("#addrs");
           }
       }).open();
   });
   
   toDisabled("#zipcds");

     $("#email").on('keyup',function(event){
         if(!eCheck.test($("#email").val())){
            emailValidate = false;
            $("#email_warn").text("유효한 이메일 주소를 입력해주세요");
            $("#email_warn").css("color","red");
         } else {
            emailValidate = true;
         }
         
         if(emailValidate == true){
            $.ajax({
               type:"POST",
               url: "validEmail",
               dataType:"json",
               data: {"email":$("#email").val()},
               success: function(res){
            	  console.log(res);
            	  console.log(res.result =="false");
                  if(res.result=="true"){
                     $("#email_warn").text("가입 가능한 이메일 주소입니다");
                     $("#email_warn").css("color","green");
                     toEnabled("#email_check_btn");
                  } else if(res.result =="false"){
                     $("#email_warn").text("이미 가입된 이메일입니다");
                     $("#email_warn").css("color","red");
                     toDisabled("#email_check_btn");
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

function toEnabled(sel){
   $(sel).attr("disabled",false);
}

function emailEnabled(){
   toEnabled("#email");
   toEnabled("#email_check_btn");
   toEnabled("#zipcds");
   toEnabled("#addrs_other");
}

function toDisabled(sel){
   $(sel).attr("disabled",true);
}

</script>
</head>
<body>
<c:import url="/layoutTopLeft"></c:import>
<main>
    <div class="con_contnr">
        <div class="join_con">
           <div class="join_form_header">
              회원가입
           </div>
           <div class="join_form_body">
              <div class="join_form">
                 <form action="joinPernlMember" id="join_form" method="post" onsubmit="emailEnabled()">
                      <div class="form_input">
                         <div class="form_input_text">
                            이름
                         </div>
                         <div class="form_input_val">
                            <input id="name" name="name"/>
                         </div>                    
                      </div>
                      <div class="form_input">
                         <div class="form_input_text">
                            닉네임
                         </div>
                         <div class="form_input_val">
                            <input id="nicnm" name="nicnm"/>
                         </div>                    
                      </div>
                      <div class="form_input" >
                         <div class="form_input_text">
                            이메일 <span><div id="email_warn"></div></span>
                         </div>
                         <div class="email_input">
                            <div class="form_input_val">
                               <input type="email" id="email" name="email"/>
                            </div>
                            <div class="check_btn">
                               <input type="button" id="email_check_btn" value="전송"/>
                            </div>
                         </div>                    
                      </div>
                      <div class="form_input hidden" id="email_check_input">
                         <div class="form_input_text">
                            이메일 인증
                         </div>
                         <div class="email_input">
                            <div class="form_input_val">
                               <input id="email_re_check" name="email_re_check" placeholder="인증번호를 입력하세요"/>
                            </div>
                            <div class="check_btn">
                                  <input type="button" id="email_re_check_btn" value="확인"/>
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
                      <div class="form_input">
                         <div class="form_input_text">
                            비밀번호 확인
                         </div>
                         <div class="form_input_val">
                            <input id="pw_check" name="pw_check"/>
                         </div>                    
                      </div>
                      
                      <div class="form_input">
                         <div class="form_input_text">
                            우편번호
                         </div>
                         <div class="form_zipcd">
                            <div class="form_input_val">
                               <input type="text" id="zipcds" name="zipcd"/>
                            </div>                    
                            <div class="find_addrs">
                               <input class="zipcd_btn" id="zipcd_btn" type="button" value="주소확인">
                            </div>       
                         </div>
                      </div>
                      
                       <div class="form_input">
                         <div class="form_input_text">
                            주소
                         </div>
                         <div class="form_input_val">
                            <input id="addrs_other" name="addrs"/>
                         </div>                    
                      </div>
                       <div class="form_input">
                         <div class="form_input_text">
                            상세주소
                         </div>
                         <div class="form_input_val">
                            <input id="dtl_addrs" name="dtl_addrs"/>
                         </div>
             
                      </div>
                                            
                      <div class="form_input agrnt_input">
                       <input type="checkbox" id="agrnt_box"/>
                         <div class="">
                            약관동의
                         </div>                 
                      </div>
                 </form>
                 <div id="joinBtn">
                    <input type="button" value="가입" id="join_btn">
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