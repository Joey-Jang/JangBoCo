<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<form action="#" id="actionForm" method="post">
	<input type="hidden" name="member_no" value="1">
</form>
<header>
    <div class="home_logo"></div>
    <div class="loc_contnr" id="loc_contnr">
        <div class="loc_icon"></div>
        <span class="loc_addrs">은평구 백련산로2길 19</span>
        <div class="loc_expand_btn" id="loc_expand_btn"></div>
        <div class="loc_expand_btn_hover" id="loc_expand_btn_hover"></div>
    </div>
    <div class="set_loc_contnr">
    	<div id="loc_info" class="loc_info">
	    	<input type="text" id="zipcd" class="zipcd" placeholder="우편번호" readonly>
			<input type="button" id="search_addrs_map_btn" class="search_addrs_map_btn" value="주소검색">
	    	<input type="text" id="addrs" class="addrs" placeholder="주소" readonly>
	    	<input type="text" id="dtl_addrs" class="dtl_addrs" placeholder="상세주소">
			<div id="loc_map" class="loc_map"></div>
			<input type="button" id="set_loc_btn" class="set_loc_btn" value="이 주소로 위치 설정">
    	</div>
		<div class="recent_loc_contnr">
			<div class="recent_loc_title">최근 위치</div>
			<ul class="recent_loc_list">
			</ul>
		</div>
    </div>
</header>
<aside>
    <div class="login_logout_menu">
        <ul class="login_menu">
            <li>
                <div class="menu_icon"></div>
                <div class="menu_icon_hover"></div>
                <span class="menu_text">로그인</span>
            </li>
            <li>
                <div class="menu_icon"></div>
                <div class="menu_icon_hover"></div>
                <span class="menu_text">함께하기</span>
            </li>
        </ul>
        <ul class="logout_menu">
            <li>
                <div class="menu_icon"></div>
                <div class="menu_icon_hover"></div>
                <span class="menu_text">회원이름</span>
            </li>
            <li>
                <div class="menu_icon"></div>
                <div class="menu_icon_hover"></div>
                <span class="menu_text">로그아웃</span>
            </li>
        </ul>
    </div>
    <div class="side_menu_contnr">
        <div class="main_menu_contnr">
            <ul class="main_menu">
                <li class="active">
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
        <div class="sub_menu_contnr">
            <ul class="sub_menu map">
                <li class="active">
                    <span class="sub_menu_text">가격비교</span>
                </li>
                <li>
                    <span class="sub_menu_text">품목별 정보</span>
                </li>
                <li>
                    <span class="sub_menu_text">차트</span>
                </li>
            </ul>
            <ul class="sub_menu diary">
                <li>
                    <span class="sub_menu_text">뉴스피드</span>
                </li>
                <li>
                    <span class="sub_menu_text">보관함</span>
                </li>
                <li>
                    <span class="sub_menu_text">마이페이지</span>
                </li>
            </ul>
            <ul class="sub_menu accbk">
                <li>
                    <span class="sub_menu_text">메인</span>
                </li>
                <li>
                    <span class="sub_menu_text">통계</span>
                </li>
                <li>
                    <span class="sub_menu_text">지출내역</span>
                </li>
            </ul>
            <ul class="sub_menu user_center">
                <li>
                    <span class="sub_menu_text">공지</span>
                </li>
                <li>
                    <span class="sub_menu_text">Q&A</span>
                </li>
            </ul>
        </div>
    </div>
</aside>