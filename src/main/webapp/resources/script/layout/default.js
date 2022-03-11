$(document).ready(function() {
	reloadMainLoc();
	reloadMenu();
	
    // 로고 클릭 이벤트
    $("#home_logo").click(function() {
    	$("#go_form").attr("action", "home");
		$("#go_form").submit();
    })
    
    // 메인 위치 설정 호버 이벤트
    $("#main_loc_contnr").hover(function() {
        $("#loc_expand_btn").hide();
        $("#loc_expand_btn_hover").show();
    }, function() {
        $("#loc_expand_btn").show();
        $("#loc_expand_btn_hover").hide();
    })
    
    // 사이드 메뉴 호버 이벤트
    $("#login_logout_menu > ul > li, #main_menu > li").hover(function() {
        $(this).children(".menu_icon").hide();
        $(this).children(".menu_icon_hover").show();
    }, function() {
        if($(this).hasClass("active")) {
            return false;
        }
        $(this).children(".menu_icon").show();
        $(this).children(".menu_icon_hover").hide();
    });
    
    // login_logout_menu 클릭 이벤트
    $("#login_logout_menu").on('click', "li", function() {
        goPage($(this));
    })
    
    // 서브 메뉴 열기/닫기
    $("#main_menu").on('click', "li", function() {
        if($(this).hasClass("open")) {
            closeSubMenu($(this));
        } else {
            openSubMenu($(this));
        }
    })
    
    // 서브 메뉴 클릭 이벤트
    $(".sub_menu").on("click", "li", function() {
        goPage($(this));
    });
    
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
		
        if($(window).width() >= 500) {
        	if($("#set_loc_contnr").css("display")=="none") {
				initLocMap();
				reloadRecentLocList();
	            $("#set_loc_contnr").show();
        	} else {
	            $("#set_loc_contnr").hide();
        	}
        }
    });
    
    // 위치 설정 창 외부 클릭 이벤트
	$(document).on("click", function(event) {
		if($(event.target).is("#set_loc_contnr, #set_loc_contnr *, #main_loc_contnr, #main_loc_contnr *")) {
			return false;
		}
		
		$("#set_loc_contnr").hide();
	});
	
	// 최근 위치 호버 이벤트
	$("#recent_loc_list").on("mouseenter", ".recent_addrs", function() {
		$(this).parent().css("border-left", "2px solid #03A64A");
	});
	$("#recent_loc_list").on("mouseleave", ".recent_addrs", function() {
		$(this).parent().css("border-left", "1px solid #E0E0E0");
	});
	
    // 최근 위치 선택 이벤트
    $("#recent_loc_list").on("click", "li > .recent_addrs_contnr > .recent_addrs", function() {
    	initLocMap();
    	$("#latest_loc_no").val($(this).parent().parent().attr("recent_loc_no"));
    	$("#zipcd").val($(this).parent().parent().find(".recent_zipcd").attr("zipcd"));
    	$("#addrs").val($(this).attr("addrs"));
    	$("#dtl_addrs").val($(this).attr("dtl_addrs"));
    });
    
    // 최근 위치 선택 후 상세 주소 수정 이벤트
    $("#dtl_addrs").on("change", function() {
    	$("#latest_loc_no").val("");
    });
    
    // 최근 위치 삭제 버튼 클릭 이벤트
    $("#recent_loc_list").on("click", ".del_recent_loc_btn", function() {
    	$("#del_recent_loc_no").val($(this).parent().attr("recent_loc_no"));
    	
    	var params = $("#loc_form").serialize();
		
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
	    	var params = $("#loc_form").serialize();
			
			$.ajax({
				url: "setLocAjax",
				type: "post",
				dataType: "json",
				data: params,
				success: function(result) {
					if(result.msg=="SUCCESS") {
						alert("위치 설정 성공");
						reloadMainLoc();
						$("#set_loc_contnr").hide();
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
    
    
	$("#set_loc_contnr").on("click", ".go_login", function() {
		$("#go_form").attr("action", "loginMain");
		$("#go_form").submit();
	});
});



// loc_map 초기화
function initLocMap() {
	$("#loc_info").css("height", "136px");
	$("#loc_map").hide();
}

// 메인 위치 갱신
function reloadMainLoc() {
	var params = $("#loc_form").serialize();
	
	$.ajax({
		url: "reloadMainLocAjax",
		type: "post",
		dataType: "json",
		data: params,
		success: function(result) {
			setMainLoc(result.memberAddrs, result.cntRecentLoc, result.latestLocData, result.cookies);
		},
		error: function(request, status, error) {
			console.log(error);
		}
	});
}

// 최근 위치 목록 갱신
function reloadRecentLocList() {
	var params = $("#loc_form").serialize();
	
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

// 메인 위치 설정
var nonmemberZipcd = "08505";
var nonmemberAddrs = "서울 금천구 가산디지털2로 115";
var nonmemberDtlAddrs = "대륭테크노타운3차 1109-1호";
function setMainLoc(memberAddrs, cntRecentLoc, latestLocData, cookies) {
	if($("#member_no").val()!="") {
		if(cntRecentLoc==0) {
			$("#main_loc_addrs").text(memberAddrs.ADDRS);
			$("#latest_loc_no").val("");
	    	$("#zipcd").val(memberAddrs.ZIPCD);
	    	$("#addrs").val(memberAddrs.ADDRS);
	    	$("#dtl_addrs").val(memberAddrs.DTL_ADDRS);
		} else {
			$("#main_loc_addrs").text(latestLocData.ADDRS);
			$("#latest_loc_no").val(latestLocData.RECENT_LOC_NO);
	    	$("#zipcd").val(latestLocData.ZIPCD);
	    	$("#addrs").val(latestLocData.ADDRS);
	    	$("#dtl_addrs").val(latestLocData.DTL_ADDRS);
		}
	} else {
		if(cookies!=null) {
			for(var cookie of cookies) {
				if(cookie.name=="nonmemberZipcd") {
					var cookieZipcd = cookie.value;
				}
				if(cookie.name=="nonmemberAddrs") {
					var cookieAddrs = decodeURIComponent(cookie.value);
				}
				if(cookie.name=="nonmemberDtlAddrs") {
					var cookieDtlAddrs = decodeURIComponent(cookie.value);
				}
			}
			if(cookieZipcd!=null && cookieAddrs!=null && cookieDtlAddrs!=null) {
				nonmemberZipcd = cookieZipcd;
				nonmemberAddrs = cookieAddrs;
				nonmemberDtlAddrs = cookieDtlAddrs;
			}
		}
		
		$("#main_loc_addrs").text(nonmemberAddrs);
    	$("#zipcd").val(nonmemberZipcd);
    	$("#addrs").val(nonmemberAddrs);
		$("#dtl_addrs").val(nonmemberDtlAddrs);
	}
}

// 최근 위치 목록 그리기
function drawRecentLocList(recentLocList) {
	var html = "";
	
	if($("#member_no").val()!="") {
		for(var data of recentLocList) {
			html += "<li recent_loc_no=\"" + data.RECENT_LOC_NO + "\">";
			html += "	<span class=\"recent_zipcd\" zipcd=\"" + data.ZIPCD + "\">" + data.ZIPCD + "</span>";
			html += "	<div class=\"recent_addrs_contnr\">";
			html += "		<span class=\"recent_addrs\" addrs=\"" + data.ADDRS + "\" dtl_addrs=\""
			if(data.DTL_ADDRS!="" && data.DTL_ADDRS!=null) {
				html += data.DTL_ADDRS;
			} else {
				html += "";
			}
			html += "\">";
			html += data.ADDRS;
			if(data.DTL_ADDRS!="" && data.DTL_ADDRS!=null) {
				html += ", " + data.DTL_ADDRS;
			}
			html += 		"</span>";
			html += "	</div>";
			html += "	<input type=\"button\" class=\"del_recent_loc_btn\" value=\"삭제\">";
			html += "</li>";
		}
	} else {
		html = "<span class=\"go_login\">로그인 후 사용할 수 있는 기능입니다.<span>";
	}
	
	$("#recent_loc_list").html(html);
}

// 서브 메뉴 열기/닫기
function openSubMenu(clickMenu) {
	$("#main_menu > li").removeClass("open");
    clickMenu.addClass("open");
    $("#main_menu .menu_text").hide();
    $("#main_menu").css("width", "100%");
    $("#main_menu_contnr").css("width", "54px");

    $(".sub_menu").hide();
    $(".sub_menu").eq(clickMenu.index()).show();
    $("#sub_menu_contnr").show();
}
function closeSubMenu(clickMenu) {
    clickMenu.removeClass("open");
    $("#main_menu .menu_text").show();
    $("#main_menu").css("width", "100%");
    $("#main_menu_contnr").css("width", "100%");

    $(".sub_menu").hide();
    $("#sub_menu_contnr").hide();
}

// 메뉴, 서브 메뉴 갱신
function reloadMenu() {
	// 메뉴 아이콘, 글자색(active)
	$("#main_menu .menu_icon_hover").hide();
	$("#main_menu .menu_icon").show();
	$("#main_menu > li").eq($("#menu_idx").val()).children(".menu_icon").hide();
	$("#main_menu > li").eq($("#menu_idx").val()).children(".menu_icon_hover").show();
	$("#main_menu > li").eq($("#menu_idx").val()).addClass("active");
	// 서브 메뉴 글자색(active)
	$(".sub_menu").eq($("#menu_idx").val()).children("li").eq($("#sub_menu_idx").val()).addClass("active");
	// 메뉴, 서브 메뉴 인덱스에 해당하는 메뉴 출력
	if($("#home_flag").val()!=1) {
		openSubMenu($("#main_menu > li").eq($("#menu_idx").val()));
	}
}

// 페이지 이동
function goPage(clickMenu) {
    $("#go_form").attr("action", clickMenu.attr("action"));
	$("#go_form").submit();
}