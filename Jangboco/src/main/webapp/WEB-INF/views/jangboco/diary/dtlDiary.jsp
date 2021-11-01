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
<link rel="stylesheet" type="text/css" href="resources/css/diary/dtlDiary.css">
<link rel="stylesheet" type="text/css" href="https://code.jquery.com/ui/1.13.0/themes/base/jquery-ui.css">
<script type="text/javascript" src="resources/script/jquery/jquery-1.12.4.min.js"></script>
<script type="text/javascript" src="https://code.jquery.com/ui/1.13.0/jquery-ui.min.js"></script>
<script type="text/javascript" src="https://rawgit.com/jackmoore/autosize/master/dist/autosize.min.js"></script>
<script type="text/javascript" src="resources/script/layout/default.js"></script>
<script type="text/javascript" src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=9a34fa20b8bdbafa1061701c69f892c1&libraries=services"></script>
<script type="text/javascript" src="resources/script/layout/addrsMapApi.js"></script>
<script type="text/javascript" src="resources/script/diary/dtlDiary.js"></script>
</head>
<body>
<c:import url="/layoutTopLeft"></c:import>
<main>
	<form action="#" id="go_form" method="post">
		<input type="hidden" id="member_no" name="member_no" value="${sessnMemberNo}">
		<input type="hidden" id="home_flag" name="home_flag" value="${homeFlag}">
		<input type="hidden" id="menu_idx" name="menu_idx" value="${menuIdx}">
		<input type="hidden" id="sub_menu_idx" name="sub_menu_idx" value="${subMenuIdx}">
	</form>
    <div class="con_contnr">
       	<form action="#" id="action_form" class="action_form" method="post">
       		<input type="hidden" id="diary_no" name="diary_no" value="${diaryNo}">
       		<input type="hidden" id="diary_member_no" name="diary_member_no">
	        <div class="con">
	            <div class="diary_img_profile_tag_contnr">
	            	<div class="diary_img_list_contnr">
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
			            <ul id="diary_img_list" class="diary_img_list"></ul>
	            	</div>
	            	<div class="like_accuse_btn_contnr">
	            		<div class="like_contnr">
	            			<div id="unlike_icon" class="unlike_icon"></div>
	            			<div id="like_icon" class="like_icon"></div>
	            			<span id="like" class="like"></span>
	            		</div>
	            		<div class="diary_accuse_info_btn_contnr">
	            			<div id="diary_accuse_info_contnr" class="diary_accuse_info_contnr" style="display:none;">
       				       		<input type="text" id="diary_accuse_title" class="accuse_title" placeholder="제목">
	    				       	<select id="diary_accuse_reason_code" class="accuse_reason_code">
	    				       		<option value="" selected disabled hidden>- 신고 사유 -</option>
	    				       		<option value="0">광고글</option>
	    				       	</select>
	    				       	<span>자세한 내용을 적어주세요.</span>
    				       		<textarea id="diary_accuse_con" class="accuse_con"></textarea>
       				       		<div class="accuse_btn_contnr">
				           			<input type="button" id="diary_accuse_submit_btn" class="accuse_submit_btn" value="접수">
				           			<input type="button" id="diary_accuse_cancel_btn" class="accuse_cancel_btn" value="취소">
       				       		</div>
	           				</div>
		            		<input type="button" id="diary_accuse_btn" class="diary_accuse_btn" value="신고">
	            		</div>
	            	</div>
		            <div class="profile_item_tag_list_contnr">
		            	<div class="profile_contnr">
		            		<div id="img_nicnm_folw_btn_contnr" class="img_nicnm_folw_btn_contnr">
		            			<div class="profile_img_nicnm_contnr">
			            			<div id="profile_img" class="profile_img"></div>
			            			<span id="nicnm" class="nicnm"></span>
		            			</div>
		            		</div>
		            		<div class="profile_diary_contnr">
		            			<div class="profile_diary_img_list_contnr">
			            			<ul id="profile_diary_img_list" class="profile_diary_img_list"></ul>
		            			</div>
		            		</div>
		            	</div>
		            	<div class="item_tag_list_dtl_contnr">
			            	<div id="item_tag_dtl_contnr" class="item_tag_dtl_contnr" style="display:none;">
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
	            </div>
	            <div class="diary_con_hastg_comnt_contnr">
	            	<div class="diary_con_hastg_contnr">
		            	<div id="diary_con_contnr" class="diary_con_contnr">
		            		<span id="diary_con"></span>
		            	</div>
		            	<ul id="hastg_list" class="hastg_list"></ul>
	            	</div>
	            	<div class="comnt_list_add_comnt_contnr_no_border">
	            		<div id="comnt_accuse_info_contnr" class="comnt_accuse_info_contnr" style="display:none;">
	            			<input type="hidden" id="accuse_comnt_no">
							<input type="text" id="comnt_accuse_title" class="accuse_title" placeholder="제목">
    				       	<select id="comnt_accuse_reason_code" class="accuse_reason_code">
    				       		<option value="" selected disabled hidden>- 신고 사유 -</option>
    				       		<option value="0">광고글</option>
    				       	</select>
    				       	<span>자세한 내용을 적어주세요.</span>
   				       		<textarea id="comnt_accuse_con" class="accuse_con"></textarea>
      				       	<div class="accuse_btn_contnr">
			           			<input type="button" id="comnt_accuse_submit_btn" class="accuse_submit_btn" value="접수">
			           			<input type="button" id="comnt_accuse_cancel_btn" class="accuse_cancel_btn" value="취소">
      				       	</div>
           				</div>
		            	<div id="comnt_list_add_comnt_contnr" class="comnt_list_add_comnt_contnr">
		            		<div class="comnt_list_contnr">
				            	<ul id="comnt_list" class="comnt_list"></ul>
		            		</div>
			            	<div class="add_comnt_contnr">
			            		<textarea class="add_comnt_con"></textarea>
			            		<input type="button" class="add_comnt_btn" value="댓글 등록">
			            	</div>
		            	</div>
	            	</div>
	            </div>
	        </div>
       	</form>
    </div>
    <div class="bottom_contnr"></div>
</main>
</body>
</html>