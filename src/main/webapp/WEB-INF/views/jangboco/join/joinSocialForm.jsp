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

	$("#cancel_btn").on("click",function(){
		history.back();
	});
	
	$("#social_join_btn").on("click",function(){
		if(checkVal("#name")){
			alert("이름을 입력해주세요");
			$("#name".focus());
    	} else if (checkVal("#nicnm")){
			alert("닉네임을 입력해주세요");
			$("#nicnm").focus();
    	} /* else if ($("#agrnt_box").prop("checked") == false){
			alert("약관동의를 확인해주세요");
		}  */else if (checkVal("#zipcd_other")){
			alert("우편번호를 입력해주세요");
			$("#zipcd_other").focus();
		} else if (checkVal("#addrs_other")){
			alert("주소를 입력해주세요");
			$("#addrs_other").focus();
		} else {
			alert("가입완료!");
			$("#social_join_form").submit();
		}
	});
	
	$("#zipcd_btn").on("click",function(){
	    new daum.Postcode({
	        oncomplete: function(data) {
	        	$("#zipcd_other").val(data['zonecode']);
	            $("#addrs_other").val(data['address']);
	            toDisabled("#addrs");
	        }
	    }).open();
	});
	
	toDisabled("#zipcd_other");
	toDisabled("#email");
	
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
	toEnabled("#zipcd_other");
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
	<form action="#" id="go_form" method="post">
      <input type="hidden" id="home_flag" name="home_flag" value="${homeFlag}">
      <input type="hidden" id="menu_idx" name="menu_idx" value="${menuIdx}">
      <input type="hidden" id="sub_menu_idx" name="sub_menu_idx" value="${subMenuIdx}">
   </form>
    <div class="con_contnr">
        <div class="join_con">
        	<div class="join_form_header">
        		소셜회원가입
        	</div>
        	<div class="join_form_body">
        		<div class="join_form">
        			<form action="joinSocialMember" id="social_join_form" method="post" onsubmit="emailEnabled()">
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
		       					이메일
		       				</div>
		       				<div class="social_email_input">
			       				<div class="form_input_val">
		    	   					<input type="email" id="email" name="email" value=${SocialEmail}>
			    
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
		       					우편번호
		       				</div>
		       				<div class="form_zipcd">
			       				<div class="form_input_val">
			       					<input type="text" id="zipcd_other" name="zipcd"/>
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
		       					       			
<!-- 		       			<div class="form_input agrnt_input">
	        				<input type="checkbox" id="agrnt_box"/>
		       				<div class="">
		       					약관동의
		       				</div>        			
		       			</div> -->
        			</form>
        			<div class="join_btn">
	        			<input type="button" value="가입" id="social_join_btn">
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