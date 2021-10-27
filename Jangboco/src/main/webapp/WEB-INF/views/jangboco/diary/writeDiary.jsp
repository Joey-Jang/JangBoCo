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
<link rel="stylesheet" type="text/css" href="resources/css/diary/writeDiary.css">
<link rel="stylesheet" type="text/css" href="https://code.jquery.com/ui/1.13.0/themes/base/jquery-ui.css">
<script type="text/javascript" src="resources/script/jquery/jquery-1.12.4.min.js"></script>
<script type="text/javascript" src="resources/script/jquery/jquery.form.js"></script>
<script type="text/javascript" src="https://code.jquery.com/ui/1.13.0/jquery-ui.min.js"></script>
<script type="text/javascript" src="https://rawgit.com/jackmoore/autosize/master/dist/autosize.min.js"></script>
<script type="text/javascript" src="resources/script/layout/default.js"></script>
<script type="text/javascript" src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=9a34fa20b8bdbafa1061701c69f892c1&libraries=services"></script>
<script type="text/javascript" src="resources/script/layout/addrsMapApi.js"></script>
<script type="text/javascript" src="resources/script/diary/writeDiary.js"></script>
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
	    <form action="fileUploadAjax" id="file_form" class="hidden_tag" method="post" enctype="multipart/form-data">
			<input type="file" accept="image/*" id="att_diary_img" name="att_diary_img">
			<input type="file" accept="image/*" id="att_change_diary_img" name="att_change_diary_img">
		</form>
       	<form action="#" id="writeDiaryForm" class="writeDiaryForm" method="post">
       		<input type="hidden" id="member_no" name="member_no" value="${memberNo}">
       		
	        <div class="con">
	            <ul id="diary_thunl_list" class="diary_thunl_list"></ul>
	            <div class="diary_img_tag_contnr">
	            	<input type="button" id="add_diary_img_btn" class="add_diary_img_btn" value="사진 추가하기">
	            	<div class="diary_img_list_contnr">
	           			<button type="button" id="no_diary_img_btn" class="no_diary_img_btn">
							<svg xmlns="http://www.w3.org/2000/svg" width="80%" height="80%" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-plus">
								<line x1="12" y1="5" x2="12" y2="19"></line>
								<line x1="5" y1="12" x2="19" y2="12"></line>
							</svg>
	           			</button>
	           			<button type="button" id="previous_slide_btn" class="previous_slide_btn">
							<svg xmlns="http://www.w3.org/2000/svg" width="100%" height="100%" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-chevron-left">
								<polyline points="15 18 9 12 15 6"></polyline>
							</svg>
	           			</button>
	           			<button type="button" id="next_slide_btn" class="next_slide_btn">
							<svg xmlns="http://www.w3.org/2000/svg" width="100%" height="100%" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-chevron-right">
								<polyline points="9 18 15 12 9 6"></polyline>
							</svg>
	           			</button>
	           			<button type="button" id="change_diary_img_btn" class="change_diary_img_btn">
							<svg xmlns="http://www.w3.org/2000/svg" width="80%" height="80%" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-rotate-cw">
								<polyline points="23 4 23 10 17 10"></polyline>
								<path d="M20.49 15a9 9 0 1 1-2.12-9.36L23 10"></path>
							</svg>
	           			</button>
	           			<button type="button" id="del_diary_img_btn" class="del_diary_img_btn">
							<svg xmlns="http://www.w3.org/2000/svg" width="80%" height="80%" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-trash-2">
								<polyline points="3 6 5 6 21 6"></polyline>
								<path d="M19 6v14a2 2 0 0 1-2 2H7a2 2 0 0 1-2-2V6m3 0V4a2 2 0 0 1 2-2h4a2 2 0 0 1 2 2v2"></path>
								<line x1="10" y1="11" x2="10" y2="17"></line><line x1="14" y1="11" x2="14" y2="17"></line>
							</svg>
	           			</button>
	           			<div class="edit_item_tag_contnr">
		           			<input type="button" id="edit_item_tag_btn" class="edit_item_tag_btn" value="상품 태그하기">
       				       	<div id="set_item_tag_contnr" class="set_item_tag_contnr">
       				       		<div id="item_tag_info" class="item_tag_info">
	    				       		<input type="hidden" id="market_no" name="market_no">
	    				       		<div id="others_market_name_contnr" class="others_market_name_contnr">
		    				       		<span>마켓 이름을 직접 입력해주세요.</span>
		    				       		<input type="text" id="market_name" name="market_name" class="market_name">
	    				       		</div>
	    				       		<input type="hidden" id="items_no" name="items_no">
	    				       		<div id="others_items_name_contnr" class="others_items_name_contnr">
		    				       		<span>품목 이름을 직접 입력해주세요.</span>
		    				       		<input type="text" id="items_name" name="items_name" class="items_name">
	    				       		</div>
	    				       		
	       				       		<div id="search_market_contnr" class="search_market_contnr">
		       				       		<select id="disct_gbn" class="disct_gbn"></select>
		       				       		<input type="text" id="search_market_name" name="search_market_name" class="search_market_name">
		       				       		<input type="button" id="search_market_btn" class="search_market_btn" value="마켓 검색">
	       				       		</div>
	       				       		<div id="market_branch_name_contnr" class="market_branch_name_contnr">
	       				       			<ul id="market_list" class="market_list"></ul>
	       				       			<ul id="branch_list" class="branch_list"></ul>
	       				       			<input type="text" id="select_market_branch_name" class="select_market_branch_name" disabled>
	       				       		</div>
	       				       		<div id="search_items_contnr" class="search_items_contnr">
		       				       		<input type="text" id="search_items_name" name="search_items_name" class="search_items_name">
		       				       		<input type="button" id="search_items_btn" class="search_items_btn" value="품목 검색">
	       				       		</div>
	       				       		<div id="items_name_contnr" class="items_name_contnr">
	       				       			<ul id="items_list" class="items_list"></ul>
	       				       			<input type="text" id="select_items_name" class="select_items_name" disabled>
	       				       		</div>
	       				       		<div id="buy_qnt_cost_contnr" class="buy_qnt_cost_contnr">
		       				       		<input type="text" id="buy_qnt" name="buy_qnt" class="buy_qnt" placeholder="구매량">
		       				       		<div class="cost_contnr">
			       				       		<input type="text" id="cost" name="cost" class="cost" placeholder="금액">
			       				       		<span class="won">원</span>
		       				       		</div>
	       				       		</div>
       				       		</div>
       				       		<div class="item_tag_btn_contnr">
	       				       		<div class="others_btn_contnr">
	       				       			<input type="button" id="others_item_tag_btn" class="others_item_tag_btn" value="직접 입력하기" gbn="0">
	       				       		</div>
	       				       		<div class="accbk_add_cancel_btn_contnr">
	       				       			<div id="accbk_btn_contnr" class="accbk_btn_contnr">
		       				       			<div id="add_to_accbk_inactive" class="add_to_accbk_inactive">
											</div>
		       				       			<div id="add_to_accbk_active" class="add_to_accbk_active">
											</div>
		       				       			<input type="button" id="add_to_accbk_btn" class="add_to_accbk_btn" value="가계부에 추가">
		       				       			<input type="text" id="buy_date" class="buy_date" placeholder="YYYY-MM-DD">
		       				       			<input type="hidden" id="add_to_accbk_flag" name="add_to_accbk_flag" value="0">
	       				       			</div>
	       				       			<div class="add_cancel_btn_contnr">
						           			<input type="button" id="add_item_tag_btn" class="add_item_tag_btn" value="등록">
						           			<input type="button" id="cancel_item_tag_btn" class="cancel_item_tag_btn" value="취소">
	       				       			</div>
	       				       		</div>
       				       		</div>
       						</div>
	           			</div>
			            <ul id="diary_img_list" class="diary_img_list"></ul>
	            	</div>
		            <div class="item_tag_list_dtl_contnr">
		            	<div id="item_tag_dtl_contnr" class="item_tag_dtl_contnr">
		            		<input type="text" id="item_tag_dtl_market_branch_name" class="item_tag_dtl_market_branch_name" disabled>
		            		<input type="text" id="item_tag_dtl_items_name" class="item_tag_dtl_items_name" disabled>
		            		<input type="text" id="item_tag_dtl_buy_qnt" class="item_tag_dtl_buy_qnt" disabled>
       				       	<div class="item_tag_dtl_cost_contnr">
	       				    	<input type="text" id="item_tag_dtl_cost" class="item_tag_dtl_cost" disabled>
	       				       	<span class="item_tag_dtl_won">원</span>
      				       	</div>
		            	</div>
		            	<div id="item_tag_list_contnr" class="item_tag_list_contnr"></div>
		            </div>
	            </div>
	            <div class="diary_con_contnr">
	            	<div class="diary_con_hastg_contnr">
		            	<textarea id="diary_con" class="diary_con">일기 내용 어찌구저찌구</textarea>
		            	<ul class="hastg_list"></ul>
	            	</div>
	            	<div class="diary_btn_contnr">
		            	<input type="button" id="write_diary_btn" class="write_diary_btn" value="올리기">
		            	<input type="button" id="cancel_diary_btn" class="cancel_diary_btn" value="취소">
	            	</div>
	            </div>
	        </div>
       	</form>
    </div>
    <div class="bottom_contnr"></div>
</main>
</body>
</html>