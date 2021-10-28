<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<header>
    <div id="home_logo" class="home_logo"></div>
    <div id="main_loc_contnr" class="main_loc_contnr">
        <div class="loc_icon"></div>
        <span id="main_loc_addrs" class="main_loc_addrs"></span>
        <div id="loc_expand_btn" class="loc_expand_btn"></div>
        <div id="loc_expand_btn_hover" class="loc_expand_btn_hover"></div>
    </div>
</header>
<div id="set_loc_contnr" class="set_loc_contnr">
	<form action="#" id="loc_form" method="post" >
	   	<div id="loc_info" class="loc_info">
			<input type="hidden" name="member_no" value="${memberNo}">
	   		<input type="hidden" id="latest_loc_no" name="latest_loc_no">
	   		<input type="hidden" id="del_recent_loc_no" name="del_recent_loc_no">
	    	<input type="text" id="zipcd" name="zipcd" class="zipcd" placeholder="우편번호" readonly>
			<input type="button" id="search_addrs_map_btn" class="search_addrs_map_btn" value="주소검색">
	    	<input type="text" id="addrs" name="addrs" class="addrs" placeholder="주소" readonly>
	    	<input type="text" id="dtl_addrs" name="dtl_addrs" class="dtl_addrs" placeholder="상세주소">
			<div id="loc_map" class="loc_map">
			</div>
			<input type="button" id="set_loc_btn" class="set_loc_btn" value="이 주소로 위치 설정">
	   	</div>
	</form>
	<div class="recent_loc_contnr">
		<div class="recent_loc_title">최근 위치</div>
		<ul id="recent_loc_list" class="recent_loc_list"></ul>
	</div>
</div>
<aside>
    <div id="login_logout_menu" class="login_logout_menu">
        <ul class="login_menu">
            <li action="loginMain">
                <div class="menu_icon"></div>
                <div class="menu_icon_hover"></div>
                <span class="menu_text">로그인</span>
            </li>
            <li action="joinMain">
                <div class="menu_icon"></div>
                <div class="menu_icon_hover"></div>
                <span class="menu_text">함께하기</span>
            </li>
        </ul>
        <ul class="logout_menu">
            <li action="">
                <div class="menu_icon"></div>
                <div class="menu_icon_hover"></div>
                <span class="menu_text">회원이름</span>
            </li>
            <li action="">
                <div class="menu_icon"></div>
                <div class="menu_icon_hover"></div>
                <span class="menu_text">로그아웃</span>
            </li>
        </ul>
    </div>
    <div class="side_menu_contnr">
        <div id="main_menu_contnr" class="main_menu_contnr">
            <ul id="main_menu" class="main_menu">
                <li>
                    <div class="menu_icon"></div>
                    <div class="menu_icon_hover"></div>
                    <span class="menu_text">짠짠맵</span>
                </li>
                <li>
                    <div class="menu_icon"></div>
                    <div class="menu_icon_hover"></div>
                    <span class="menu_text">장보코 일기</span>
                </li>
                <li>
                    <div class="menu_icon"></div>
                    <div class="menu_icon_hover"></div>
                    <span class="menu_text">가계부</span>
                </li>
                <li>
                    <div class="menu_icon"></div>
                    <div class="menu_icon_hover"></div>
                    <span class="menu_text">고객센터</span>
                </li>
            </ul>
        </div>
        <div id="sub_menu_contnr" class="sub_menu_contnr">
            <ul class="sub_menu map">
                <li action="zzanMain">
                    <span class="sub_menu_text">가격비교</span>
                </li>
                <li action="">
                    <span class="sub_menu_text">품목별 정보</span>
                </li>
                <li action="">
                    <span class="sub_menu_text">차트</span>
                </li>
            </ul>
            <ul class="sub_menu diary">
                <li action="diaryMain">
                    <span class="sub_menu_text">뉴스피드</span>
                </li>
                <li action="diaryLike">
                    <span class="sub_menu_text">보관함</span>
                </li>
                <li action="">
                    <span class="sub_menu_text">마이페이지</span>
                </li>
                <li action="writeDiary">
                    <span class="sub_menu_text">일기 올리기</span>
                </li>
            </ul>
            <ul class="sub_menu accbk">
                <li action="accbkMain">
                    <span class="sub_menu_text">메인</span>
                </li>
                <li action="accbkChart">
                    <span class="sub_menu_text">통계</span>
                </li>
                <li action="accbkR">
                    <span class="sub_menu_text">지출내역</span>
                </li>
            </ul>
            <ul class="sub_menu user_center">
                <li action="">
                    <span class="sub_menu_text">공지</span>
                </li>
                <li action="">
                    <span class="sub_menu_text">Q&amp;A</span>
                </li>
            </ul>
        </div>
    </div>
</aside>