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
<link rel="stylesheet" type="text/css" href="resources/css/admin/memberManage.css">
<script type="text/javascript" src="resources/script/jquery/jquery-1.12.4.min.js"></script>
<script type="text/javascript" src="resources/script/layout/default.js"></script>
<script type="text/javascript" src="resources/script/admin/memberManage.js"></script>
<script type="text/javascript" src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=9a34fa20b8bdbafa1061701c69f892c1&libraries=services"></script>
<script type="text/javascript" src="resources/script/layout/addrsMapApi.js"></script>
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
        	<div class="list_contnr">
	        	<span class="member_manage_title">일반회원 관리</span>
	        	
	            <table id="member_list" class="member_list">
	       			<thead>
	       				<tr>
	       					<th>회원번호</th>
	       					<th>이메일</th>
	       					<th>이름</th>
	       					<th>닉네임</th>
	       					<th>우편번호</th>
	       					<th>주소</th>
	       					<th>상세주소</th>
	       					<th>가입일</th>
	       					<th>탈퇴일</th>
	       				</tr>
	       			</thead>
	       			<tbody>
	       			</tbody>
	       		</table>
        	</div>
        	<div class="search_paging_contnr">
		   		<form action="#" id="action_form" class="action_form" method="post">
					<input type="hidden" id="page" name="page" value="${page}">
					
					<select id="search_gbn" class="search_gbn" name="search_gbn">
						<option value="0">이메일</option>
						<option value="1">이름</option>
						<option value="2">닉네임</option>
					</select>
					<input type="text" id="search_txt" class="search_txt" name="search_txt" value="${param.search_txt}">
					<input type="hidden" id="old_txt" value="${param.search_txt}">
					<input type="button" id="search_btn" class="search_btn" value="검색">
				</form>
			    <div id="paging_contnr" class="paging_contnr"></div>
        	</div>
        </div>
    </div>
    <div class="bottom_contnr"></div>
</main>
</body>
</html>