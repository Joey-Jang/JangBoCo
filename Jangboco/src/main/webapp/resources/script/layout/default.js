$(document).ready(function() {
	reloadMainLoc();
	reloadRecentLocList();

    // 로고 클릭 이벤트
    $("#home_logo").click(function() {
        reloadMainLoc();
		reloadRecentLocList();
    })
    
    // 메인 위치 설정 호버 이벤트
    $("#main_loc_contnr").hover(function() {
        $("#loc_expand_btn").css("display", "none");
        $("#loc_expand_btn_hover").css("display", "block");
    }, function() {
        $("#loc_expand_btn").css("display", "block");
        $("#loc_expand_btn_hover").css("display", "none");
    })
    
    // 사이드메뉴 호버 이벤트
    $("#login_logout_menu > ul > li, #main_menu > li").hover(function() {
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
    $("#main_menu").on('click', "li", function() {
        var index = $(this).index();
        
        if($(this).hasClass("close")) { // 메인 메뉴 열기
            $(this).removeClass("close");
            $("#main_menu .menu_text").css("display", "block");
            $("#main_menu").css("width", "100%");
            $("#main_menu_contnr").css("width", "100%");
            $("#main_menu_contnr").css("border-right", "");

            $(".sub_menu").css("display", "none");
            $("#sub_menu_contnr").css("display", "none");
        } else { // 닫기
            $("#main_menu > li").removeClass("close");
            $(this).addClass("close");
            $("#main_menu .menu_text").css("display", "none");
            $("#main_menu").css("width", "100%");
            $("#main_menu_contnr").css("width", "56px");
            $("#main_menu_contnr").css("border-right", "2px solid #F0F0F0");

            $(".sub_menu").css("display", "none");
            $(".sub_menu").eq(index).css("display", "block");
            $("#sub_menu_contnr").css("display", "flex");
        }
    })
    
    // login_logout_menu 클릭 이벤트 - 메인 메뉴, 하위 메뉴 초기화
    $("#login_logout_menu").on('click', "li", function() {
        $("#main_menu .menu_icon").css("display", "block");
        $("#main_menu .menu_icon_hover").css("display", "none");
        $("#main_menu > li").attr("class", "");
        $("#main_menu .menu_text").css("display", "block");
        $("#main_menu").css("width", "100%");
        $("#main_menu_contnr").css("width", "100%");
        $("#main_menu_contnr").css("border-right", "");

        $(".sub_menu").children("li").attr("class", "");
        $(".sub_menu").css("display", "none");
        $("#sub_menu_contnr").css("display", "none");
    })
    
    // 서브 메뉴 클릭 이벤트
    $(".sub_menu").on("click", "li", function() {
        var index = $(this).parent().index();

        $(".sub_menu").children("li").attr("class", "");
        $(this).addClass("active");
        $("#main_menu > li").removeClass("active");
        $("#main_menu > li").eq(index).addClass("active");
        $("#main_menu .menu_icon").css("display", "block");
        $("#main_menu .menu_icon_hover").css("display", "none");
        $("#main_menu > li").eq(index).children(".menu_icon").css("display", "none");
        $("#main_menu > li").eq(index).children(".menu_icon_hover").css("display", "block");
    });



    // 메인 위치 갱신
    function reloadMainLoc() {
		var params = $("#locForm").serialize();
		
		$.ajax({
			url: "reloadMainLocAjax",
			type: "post",
			dataType: "json",
			data: params,
			success: function(result) {
				setMainLoc(result.memberNo, result.cntRecentLoc, result.latestLocData, result.memberAddrs);
			},
			error: function(request, status, error) {
				console.log(error);
			}
		});
	}
	
	// 최근 위치 목록 갱신
	function reloadRecentLocList() {
		var params = $("#locForm").serialize();
		
		$.ajax({
			url: "reloadRecentLocListAjax",
			type: "post",
			dataType: "json",
			data: params,
			success: function(result) {
				drawRecentLocList(result.recentLocList);
			},
			error: function(request, status, error) {
				console.log(error);
			}
		});
	}
        
    // window 크기 변화 시 위치 설정 창 숨기기
    var timerHandler;
    $(window).on("resize", function() {
        clearTimeout(timerHandler);

        timerHandler = setTimeout(function() {
            if($(window).width() < 500) {
                $("#set_loc_contnr").hide();
            }
        }, 300);
    });

	// 메인 위치 클릭 이벤트 => 위치 설정 창
    $("#main_loc_contnr").on("click", function() {
		reloadMainLoc();
		$("#loc_info").css("height", "136px");
		$("#loc_map").hide();
		
        if($(window).width() >= 500) {
            $("#set_loc_contnr").toggle();
        }
    });
    
    // 위치 설정 창 외부 클릭 이벤트
	$(document).on("click", function(event) {
		if($(event.target).is("#set_loc_contnr, #set_loc_contnr *, #main_loc_contnr, #main_loc_contnr *")) {
			return false;
		}
		
		$("#set_loc_contnr").hide();
	});
	
	// 메인 위치 설정
	function setMainLoc(memberNo, cntRecentLoc, latestLocData, memberAddrs) {
		if(memberNo!=null) {
			$("#member_no").val(memberNo);
			if(cntRecentLoc > 0) {
				$("#main_loc_addrs").html(latestLocData.ADDRS);
				$("#latest_loc_no").val(latestLocData.RECENT_LOC_NO);
		    	$("#zipcd").val(latestLocData.ZIPCD);
		    	$("#addrs").val(latestLocData.ADDRS);
		    	$("#dtl_addrs").val(latestLocData.DTL_ADDRS);
			} else {
				$("#main_loc_addrs").html(memberAddrs.ADDRS);
				$("#latest_loc_no").val("");
		    	$("#zipcd").val(memberAddrs.ZIPCD);
		    	$("#addrs").val(memberAddrs.ADDRS);
		    	$("#dtl_addrs").val(memberAddrs.DTL_ADDRS);
			}
		} else {
			$("#main_loc_addrs").html("비회원 주소");
			$("#latest_loc_no").val("");
	    	$("#zipcd").val("01234");
	    	$("#addrs").val("비회원 주소");
	    	$("#dtl_addrs").val("비회원 상세주소");
		}
	}
	
    // 최근 위치 목록 그리기
    function drawRecentLocList(recentLocList) {
    	var html = "";
    	
    	for(var data of recentLocList) {
    		html += "<li no=\"" + data.RECENT_LOC_NO + "\">";
    		html += "	<div class=\"recent_zipcd\" value=\"" + data.ZIPCD + "\">" + data.ZIPCD + "</div>";
    		html += "	<div class=\"recent_addrs_contnr\">";
    		html += "		<div class=\"recent_addrs\" value=\"" + data.ADDRS +"\">" + data.ADDRS + "</div>";
    		html += "		<div class=\"recent_dtl_addrs\" value=\"";
    		if(data.DTL_ADDRS!="" && data.DTL_ADDRS!=null) {
    			html += data.DTL_ADDRS;
    		} else {
    			html += "";
    		}
    		html += "\">";
    		if(data.DTL_ADDRS!="" && data.DTL_ADDRS!=null) {
    			html += data.DTL_ADDRS;
    		} else {
    			html += "";
    		}
    		html += "</div>";
    		html += "	</div>";
    		html += "	<input type=\"button\" class=\"del_recent_loc_btn\" value=\"삭제\">";
    		html += "</li>";
    	}
    	
    	$("#recent_loc_list").html(html);
    }

    // 최근 위치 선택 이벤트
    $("#recent_loc_list").on("click", "li > .recent_addrs_contnr > div", function() {
    	$("#latest_loc_no").val($(this).parent().parent().attr("no"));
    	$("#zipcd").val($(this).parent().parent().find(".recent_zipcd").attr("value"));
    	$("#addrs").val($(this).parent().parent().find(".recent_addrs").attr("value"));
    	$("#dtl_addrs").val($(this).parent().parent().find(".recent_dtl_addrs").attr("value"));
    	$("#loc_info").css("height", "136px");
    	$("#loc_map").hide();
    });
    
    // 최근 위치 선택 후 상세 주소 수정 이벤트
    $("#dtl_addrs").on("change", function() {
    	$("#latest_loc_no").val("");
    });
    
    // 최근 위치 삭제 버튼 클릭 이벤트
    $("#recent_loc_list").on("click", ".del_recent_loc_btn", function() {
    	$("#del_recent_loc_no").val($(this).parent().attr("no"));
    	
    	var params = $("#locForm").serialize();
		
		$.ajax({
			url: "delRecentLocDataAjax",
			type: "post",
			dataType: "json",
			data: params,
			success: function(result) {
				if(result.msg=="SUCCESS") {
					reloadRecentLocList();
				} else if(result.msg=="FAILED") {
					alert("최근 위치 삭제에 실패하였습니다.");
				} else {
					alert("최근 위치 삭제 중 문제가 발생하였습니다.");
				};
			},
			error: function(request, status, error) {
				console.log(error);
			}
		});
    });
    
    // 위치 설정 버튼 클릭 이벤트
    $("#set_loc_btn").on("click", function() {
    	if($("#zipcd").val()=="" || $("#addrs").val()=="") {
    		alert("주소를 입력해주세요.");
    	} else {
	    	var params = $("#locForm").serialize();
			
			$.ajax({
				url: "setLocAjax",
				type: "post",
				dataType: "json",
				data: params,
				success: function(result) {
					if(result.msg=="SUCCESS") {
						alert("위치 설정 성공");
						$("#loc_info").css("height", "136px");
    					$("#loc_map").hide();
						$("#set_loc_contnr").hide();
						reloadMainLoc();
						reloadRecentLocList();
					} else if(result.msg=="FAILED") {
						alert("위치 설정에 실패하였습니다.");
					} else {
						alert("위치 설정 중 문제가 발생하였습니다.");
					};
				},
				error: function(request, status, error) {
					console.log(error);
				}
			});
    	}
    });
});