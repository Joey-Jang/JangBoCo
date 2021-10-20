$(document).ready(function() {
	reloadPage();

    // 로고 클릭 이벤트 - 새로고침
    $(".home_logo").click(function() {
        reloadPage();
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
            $(".main_menu").css("width", "100%");
            $(".main_menu_contnr").css("width", "100%");
            $(".main_menu_contnr").css("border-right", "");

            $(".sub_menu").css("display", "none");
            $(".sub_menu_contnr").css("display", "none");
        } else { // 닫기
            $(".main_menu > li").removeClass("close");
            $(this).addClass("close");
            $(".main_menu .menu_text").css("display", "none");
            $(".main_menu").css("width", "100%");
            $(".main_menu_contnr").css("width", "56px");
            $(".main_menu_contnr").css("border-right", "2px solid #F0F0F0");

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
        $(".main_menu").css("width", "100%");
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
    
    // window 크기 변화시 위치설정창 끄기 함수
    var timerHandler;
    function setAddrsHideEvent() {
        clearTimeout(timerHandler);

        timerHandler = setTimeout(function() {
            if($(window).width() < 530) {
                $(".set_loc_contnr").hide();
                $(this).off();
            }
        }, 300);
    };

    $(window).on("resize.setAddrsHideEvent", setAddrsHideEvent);

	// loc_contnr 클릭 이벤트
    $(".loc_contnr").on("click", function(thisEvent) {
        if($(window).width() >= 530) {
            $(".set_loc_contnr").toggle();
            if($._data($(window)[0], "events")==undefined || $._data($(window)[0], "events")==null) {
                $(window).on("resize.setAddrsHideEvent", setAddrsHideEvent);
            } else {
                var eventEntries = Object.entries($._data($(window)[0], "events"));
                for(var i=0; i<eventEntries.length; i++) {
                    var eventCatagory = eventEntries[i];
                    if(eventCatagory[0]=="resize") {
                        var eventList = eventCatagory[1];
                        for(var j=0; j<eventList.length; i++) {
                            var event = eventList[i];
                            if(event.namespace=="setAddrsHideEvent") {
                                return false;
                            }
                        }
                    }
                }
                $(window).on("resize.setAddrsHideEvent", setAddrsHideEvent);
            }
        }
    });
    
    // set_loc_contnr 외부 클릭 이벤트
    //
    //
    
    // 최근 위치 선택 버튼 클릭 이벤트
    $(".recent_loc_list").on("click", ".select_recent_loc_btn", function() {
    	$("#zipcd").val($(this).parent().children("span.recent_zipcd").attr("value"));
    	$("#addrs").val($(this).parent().children("span.recent_addrs").attr("value"));
    	$("#dtl_addrs").val($(this).parent().children("span.recent_dtl_addrs").attr("value"));
    });
    // 최근 위치 삭제 버튼 클릭 이벤트
    $(".recent_loc_list").on("click", ".del_recent_loc_btn", function() {
    	$(this).parent().remove();
    });
    
    // 페이지 로드
    function reloadPage() {
		var params = $("#actionForm").serialize();
		
		$.ajax({ // jquery의 ajax함수 호출
			url: "reloadPageAjax",
			type: "post",
			dataType: "json",
			data: params,
			success: function(result) {
				drawRecentLocList(result.list);
			},
			error: function(request, status, error) {
				console.log(error);
			}
		});
	}
    
    // 최근 위치 출력
    function drawRecentLocList(list) {
    	var html = "";
    	
    	for(var data of list) {
    		html += "<li>";
    		html += "	<span class=\"recent_zipcd\" value=\""+ data.ZIPCD +"\">" + data.ZIPCD + "</span>";
    		html += "	<span class=\"recent_addrs\" value=\""+ data.ADDRS +"\">" + data.ADDRS + "</span><br>";
    		html += "	<span class=\"recent_dtl_addrs\" value=\""+ data.DTL_ADDRS +"\">" + data.DTL_ADDRS + "</span>";
    		html += "	<input type=\"button\" class=\"select_recent_loc_btn\" value=\"선택\">";
    		html += "	<input type=\"button\" class=\"del_recent_loc_btn\" value=\"삭제\">";
    		html += "</li>";
    	}
    	
    	$(".recent_loc_list").html(html);
    }
});