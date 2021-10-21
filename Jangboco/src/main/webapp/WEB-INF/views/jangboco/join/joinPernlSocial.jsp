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
<script type="text/javascript" src="resources/script/layout/default.js"></script>
<script>
var apiUrl = "";

function getUrl(){
	location.href = apiUrl;
}
	$(document).ready(function(){
		$.ajax({
			url:"naverLoginAjax",
			type:"post",
			async: false,
			success: function(res){
				apiUrl = res['url'];
			},
			error: function(error){
				console.log(error);
			}
		})
	});
</script>
</script>
</head>
<body>
<c:import url="/layoutTopLeft"></c:import>
<main>
    <div class="con_contnr">
        <div class="con">
            <div class="join_contnr">
            	<a href=""><div class="join_btn">네이버 회원가입</div></a>
            	 <a href="" onClick="getUrl(); return false;"><img height="50" src="http://static.nid.naver.com/oauth/small_g_in.PNG"/></a>
            	<div class="join_btn">카카오톡 회원가입</div>
            </div>
        </div>
    </div>
    <div class="bottom_contnr"></div>
</main>
</body>
</html>