<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>가계부-지출 내역 목록</title>
<link rel="preconnect" href="https://fonts.gstatic.com">
<link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100;300;400;500;700;900&display=swap">
<link rel="stylesheet" type="text/css" href="resources/css/layout/default.css">
<link rel="stylesheet" href="resources/css/accbk/accbk.css" type="text/css">
<script type="text/javascript" src="resources/script/jquery/jquery-1.12.4.min.js"></script>
<script type="text/javascript" src="resources/script/layout/default.js"></script>
<script type="text/javascript" src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=9a34fa20b8bdbafa1061701c69f892c1&libraries=services"></script>
<script type="text/javascript" src="resources/script/layout/addrsMapApi.js"></script>
<script type="text/javascript" src="resources/script/accbk/accbkR.js"></script>
</head>
<body>
<c:import url="/layoutTopLeft"></c:import>
<main>
	 <form action="#" id="go_form" method="post">
         <input type="hidden" id="member_no" name="member_no" value="${memberNo}">
      <input type="hidden" id="home_flag" name="home_flag" value="${homeFlag}">
      <input type="hidden" id="menu_idx" name="menu_idx" value="${menuIdx}">
      <input type="hidden" id="sub_menu_idx" name="sub_menu_idx" value="${subMenuIdx}">
   </form>
    <div class="con_contnr">
        <div class="con">
			<!--품목 & 구입처로 검색할 수 있게 하기.  -->
			<input type="button" id="write_btn" value="지출내역추가" >
			<div>
			<table>
				<thead>
				 	<tr>
				 		<th><input type="checkbox" name="del_chkbx" class="chkbx_all" ></th>
				 		<th>구입처</th>
				 		<th>품목</th>
				 		<th>구매량</th>
				 		<th>금액</th>
				 		<th>비고</th>
				 		<th>구입 일자</th>
				 		<th>수정</th>
				 	</tr>
				</thead>
				<tbody></tbody>
			</table>
			</div>
			<form action="#" id="move_update">
				<input type='hidden' id="update_no" name="update_no"/>
			</form>
			<input type="button" id="select_del_btn" value="선택 삭제">
			<input type="button" id="del_btn" value="삭제">
			<input type="button" id="del_cancel_btn" value="취소" >
			<br>
			<div>
			<form action="#" id="action_form" method="post">
				<input type="hidden" id="page" name="page" value="${page}">
				<select id="search_gbn" name="search_gbn">
					<option hidden="" disabled="disabled" selected="selected">검색</option>
					<option value="search_items">품목</option>
					<option value="search_buy_market">구입처</option>
				</select>
				<input type="text" id="search_text" name="search_text" value="${param.search_text}">
				<input type="button" id="search_btn" value="검색">
				
				
			</form>
			</div>
			<div id="paging_wrap" class="paging_wrap"></div>
        </div>
    </div>
    <div class="bottom_contnr"></div>
</main>
</body>
</html>