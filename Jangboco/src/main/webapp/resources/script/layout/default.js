$(document).ready(function() {
    // 로고 클릭 이벤트 - 새로고침
    $(".home_logo").click(function() {
        location.reload();
    })
    // 위치 설정 호버 이벤트
    $("#loc_contnr").hover(function() {
        $("#loc_expand_btn").css("display", "none");
        $("#loc_expand_btn_hover").css("display", "block");
    }, function() {
        $("#loc_expand_btn").css("display", "block");
        $("#loc_expand_btn_hover").css("display", "none");
    })
    // 사이드메뉴 호버 이벤트
    $(".login_logout_menu > ul > li, .main_menu > li").hover(function() {
        $(this).children(".menu_icon").css("display", "none");
        $(this).children(".menu_icon_hover").css("display", "block");
    }, function() {
        if($(this).hasClass("active")) {
            return false;
        }
        $(this).children(".menu_icon").css("display", "block");
        $(this).children(".menu_icon_hover").css("display", "none");
    });
    // 메인 메뉴 열기/닫기
    $(".main_menu").on('click', "li", function() {
        var index = $(this).index();
        
        if($(this).hasClass("close")) { // 메인 메뉴 열기
            $(this).removeClass("close");
            $(".main_menu .menu_text").css("display", "block");
            $(".main_menu").css("width", "calc(100% - 30px)");
            $(".main_menu_contnr").css("width", "100%");
            $(".main_menu_contnr").css("border-right", "");

            $(".sub_menu").css("display", "none");
            $(".sub_menu_contnr").css("display", "none");
        } else { // 닫기
            $(".main_menu > li").removeClass("close");
            $(this).addClass("close");
            $(".main_menu .menu_text").css("display", "none");
            $(".main_menu").css("width", "24px");
            $(".main_menu_contnr").css("width", "54px");
            $(".main_menu_contnr").css("border-right", "2px solid #F2F2F2");

            $(".sub_menu").css("display", "none");
            $(".sub_menu").eq(index).css("display", "block");
            $(".sub_menu_contnr").css("display", "flex");
        }
    })
    // login_menu 클릭 이벤트 - 메인 메뉴, 하위 메뉴 초기화
    $(".login_menu").on('click', "li", function() {
        $(".main_menu .menu_icon").css("display", "block");
        $(".main_menu .menu_icon_hover").css("display", "none");
        $(".main_menu > li").attr("class", "");
        $(".main_menu .menu_text").css("display", "block");
        $(".main_menu").css("width", "calc(100% - 30px)");
        $(".main_menu_contnr").css("width", "100%");
        $(".main_menu_contnr").css("border-right", "");

        $(".sub_menu").children("li").attr("class", "");
        $(".sub_menu").css("display", "none");
        $(".sub_menu_contnr").css("display", "none");
    })
    // 서브 메뉴 클릭 이벤트
    $(".sub_menu").on("click", "li", function() {
        var index = $(this).parent().index();

        $(".sub_menu").children("li").attr("class", "");
        $(this).addClass("active");
        $(".main_menu > li").removeClass("active");
        $(".main_menu > li").eq(index).addClass("active");
        $(".main_menu .menu_icon").css("display", "block");
        $(".main_menu .menu_icon_hover").css("display", "none");
        $(".main_menu > li").eq(index).children(".menu_icon").css("display", "none");
        $(".main_menu > li").eq(index).children(".menu_icon_hover").css("display", "block");
    });
});