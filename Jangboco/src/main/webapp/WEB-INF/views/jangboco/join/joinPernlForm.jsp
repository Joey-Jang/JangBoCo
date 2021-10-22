main.jsp
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
<link rel="stylesheet" type="text/css" href="resources/css/join/default.css">
<script type="text/javascript" src="resources/script/jquery/jquery-1.12.4.min.js"></script>
<script type="text/javascript" src="resources/script/layout/default.js"></script>

</head>
<body>
<c:import url="/layoutTopLeft"></c:import>
<main>
    <div class="con_contnr">
        <div class="con">
            <div class="join_contnr">
               <div class="join_pernl_btn" onClick="location.href='joinPernl'">개인회원가입</div>
               <div class="join_market_btn" onClick="location.href='joinMarketForm'">마켓회원가입</div>
            </div>
        </div>
    </div>
    <div class="bottom_contnr"></div>
</main>
</body>
</html>