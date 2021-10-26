$(document).ready(function() {
	var diaryImgIdx = 0;
	showSlide(diaryImgIdx);

	// 슬라이드 전/후 버튼 클릭 이벤트
	$("#previous_slide_btn").on("click", function() {
		showSlide(diaryImgIdx -= 1);
	});
	$("#next_slide_btn").on("click", function() {
		showSlide(diaryImgIdx += 1);
	});
	
	// 사진 추가 버튼 클릭 이벤트
	$("#add_diary_img_btn, #no_diary_img_btn").on("click", function() {
		if($("#diary_img_list li").length==6) {
			alert("사진은 여섯장까지만 추가할 수 있습니다.");
			return false;
		}
		$("#att_diary_img").click();
	});
	
	// 사진 추가 ajax
	var diaryImgArray = new Array();
	var itemTagArray = new Array();
	$("#att_diary_img").on("change", function() {
		if($("#diary_img_list li").length==6) {
			alert("사진은 여섯장까지만 추가할 수 있습니다.");
			return false;
		}
		
		var fileForm = $("#file_form");
		
		fileForm.ajaxForm({
			success: function(result) {
				if(result.result=="SUCCESS") {
					if(result.fileName.length > 0) {
						$("#att_diary_img").val("");
						
						$("#diary_img_list").append("<li><div class=\"diary_img\"></div></li>");
						$("#diary_img_list > li").last().children(".diary_img").css("background", "center / cover no-repeat "
																					+ " url(\"resources/upload/"
																					+ result.fileName[0].replace(/\[/g, "%5B").replace(/\]/g, "%5D")
																					+ "\")");
						$("#diary_thunl_list").append("<li>"
														+ "<div class=\"diary_thunl\"></div>"
														+ "<button type=\"button\" class=\"del_diary_thunl_btn\" style=\"display:none;\">"
														+ "<svg xmlns=\"http://www.w3.org/2000/svg\" width=\"80%\" height=\"80%\" viewBox=\"0 0 24 24\" fill=\"none\" stroke=\"currentColor\" stroke-width=\"2\" stroke-linecap=\"round\" stroke-linejoin=\"round\" class=\"feather feather-trash-2\">"
														+ "<polyline points=\"3 6 5 6 21 6\"></polyline>"
														+ "<path d=\"M19 6v14a2 2 0 0 1-2 2H7a2 2 0 0 1-2-2V6m3 0V4a2 2 0 0 1 2-2h4a2 2 0 0 1 2 2v2\"></path>"
														+ "<line x1=\"10\" y1=\"11\" x2=\"10\" y2=\"17\"></line><line x1=\"14\" y1=\"11\" x2=\"14\" y2=\"17\"></line>"
														+ "</svg>"
	           											+ "</button>"
													+ "</li>");
						$("#diary_thunl_list > li").last().children(".diary_thunl").css("background", "center / cover no-repeat "
																						+ " url(\"resources/upload/"
																						+ result.fileName[0].replace(/\[/g, "%5B").replace(/\]/g, "%5D")
																						+ "\")");
						$("#item_tag_list_contnr").append("<ul class=\"item_tag_list\"></ul>");
						
						diaryImgArray.push(result.fileName[0]);
						itemTagArray.push(new Array());
						showSlide(diaryImgIdx = $("#diary_img_list li").length - 1);
					}
				} else {
					alert("사진 업로드에 실패하였습니다.");
				}
			},
			error: function(request, status, error) {
				console.log(error);
				alert("사진 업로드 중 문제가 발생하였습니다.");
			}
		});
		
		fileForm.submit();
	});
	
	// 사진 교체 버튼 클릭 이벤트
	$("#change_diary_img_btn").on("click", function() {
		$("#att_change_diary_img").click();
	});
	
	// 사진 교체 ajax
	$("#att_change_diary_img").on("change", function() {
		var fileForm = $("#file_form");
		
		fileForm.ajaxForm({
			success: function(result) {
				if(result.result=="SUCCESS") {
					if(result.fileName.length > 0) {
						$("#att_change_diary_img").val("");
						
						$("#diary_img_list > li").eq(diaryImgIdx).children(".diary_img").css("background", "center / cover no-repeat "
																							+ " url(\"resources/upload/"
																							+ result.fileName[0].replace(/\[/g, "%5B").replace(/\]/g, "%5D")
																							+ "\")");
						$("#diary_thunl_list > li").eq(diaryImgIdx).children(".diary_thunl").css("background", "center / cover no-repeat "
																								+ " url(\"resources/upload/"
																								+ result.fileName[0].replace(/\[/g, "%5B").replace(/\]/g, "%5D")
																								+ "\")");
						
						diaryImgArray[diaryImgIdx] = result.fileName[0];
					}
				} else {
					alert("사진 업로드에 실패하였습니다.");
				}
			},
			error: function(request, status, error) {
				console.log(error);
				alert("사진 업로드 중 문제가 발생하였습니다.");
			}
		});
		
		fileForm.submit();
	});
	
	// 사진 삭제 버튼 클릭 이벤트
	$("#del_diary_img_btn").on("click", function() {
		$("#diary_thunl_list > li").eq(diaryImgIdx).remove();
		
		$("#diary_img_list > li").eq(diaryImgIdx).remove();
		diaryImgArray.splice(diaryImgIdx, 1);
		itemTagArray.splice(diaryImgIdx, 1);
		
		$(".item_tag_list").eq(diaryImgIdx).remove();
		
		if(diaryImgIdx > $("#diary_img_list li").length - 1) {
			diaryImgIdx = $("#diary_img_list li").length - 1;
		}
		showSlide(diaryImgIdx);
	})
	
	// 썸네일 호버 이벤트
	$("#diary_thunl_list").on("mouseover", "li", function() {
		$(this).children(".del_diary_thunl_btn").show();
	});
	$("#diary_thunl_list").on("mouseout", "li", function() {
		$(this).children(".del_diary_thunl_btn").hide();
	});
	
	// 썸네일 클릭 이벤트
	$("#diary_thunl_list").on("click", ".diary_thunl", function() {
		showSlide(diaryImgIdx = $(this).parent().index());
	});
	
	// 썸네일 삭제 버튼 클릭 이벤트
	$("#diary_thunl_list").on("click", ".del_diary_thunl_btn", function() {
		var diaryThunlIdx = $(this).parent().index();
		
		$("#diary_thunl_list > li").eq(diaryThunlIdx).remove();
		
		$("#diary_img_list > li").eq(diaryThunlIdx).remove();
		diaryImgArray.splice(diaryThunlIdx, 1);
		itemTagArray.splice(diaryThunlIdx, 1);
		
		$(".item_tag_list").eq(diaryThunlIdx).remove();
		
		if(diaryImgIdx > $("#diary_img_list li").length - 1) {
			diaryImgIdx = $("#diary_img_list li").length - 1;
		}
		showSlide(diaryImgIdx);
	});
	
	// 태그 편집 버튼 클릭 이벤트
	$("#edit_item_tag_btn").on("click", function() {
		if($("#set_item_tag_contnr").css("display")=="none") {
			initItemTagInfo();
			
			$("#search_market_name").val("");
			$("#others_market_name_contnr").hide();
			$("#others_items_name_contnr").hide();
			
			$("#others_item_tag_btn").val("직접 입력하기");
			
			$("#add_to_accbk_active").hide();
			$("#add_to_accbk_inactive").show();
			$("#buy_date").hide();
			$("#buy_date").val("");
			$("#add_to_accbk_btn").removeClass("active");
			$("#add_to_accbk_btn").show();
			$("#add_to_accbk_flag").val("0");
			
			$("#search_market_contnr").show();
			$("#others_market_name_contnr").hide();
			$("#others_items_name_contnr").hide();
			$("#buy_qnt_cost_contnr").hide();
			
			$.ajax({
				url: "getDisctListAjax",
				type: "post",
				dataType: "json",
				success: function(result) {
					drawDisctList(result.disctList);
				},
				error: function(request, status, error) {
					console.log(error);
				}
			});
			$("#set_item_tag_contnr").css("display", "flex");
		}
	});
	
	// 마켓 검색 버튼 클릭 이벤트
	$("#search_market_name").on("keypress", function(event) {
		if(event.keyCode==13) {
			$("#search_market_btn").click();
			return false;
		}
	});
	$("#search_market_btn").on("click", function() {
		initItemTagInfo();
		
		var params = {
						"disctNo": $("#disct_gbn > option:selected").val(),
					 	"searchMarketName": $("#search_market_name").val()
					 };
		
		$.ajax({
			url: "searchMarketAjax",
			type: "post",
			dataType: "json",
			data: params,
			success: function(result) {
				drawMarketList(result.marketList);
				$("#market_list").show();
				$("#market_branch_name_contnr").show();
			},
			error: function(request, status, error) {
				console.log(error);
			}
		});
	});
	
	// 마켓 검색 목록 호버 이벤트
	$("#market_list").on("mouseover", "span", function() {
		$(this).parent().children(".marker").css("border-left", "2px solid #03A64A");
	});
	$("#market_list").on("mouseout", "span", function() {
		$(this).parent().children(".marker").css("border-left", "");
	});
	
	// 마켓 검색 목록 클릭 이벤트
	var marketName = "";
	$("#market_list").on("click", "span", function() {
		$("#market_list").hide();
		
		$("#market_no").val($(this).parent().attr("market_no"));
		marketName = $(this).text();
		
		var params = {
						"marketNo": $("#market_no").val()
					 };
		
		$.ajax({
			url: "searchBranchAjax",
			type: "post",
			dataType: "json",
			data: params,
			success: function(result) {
				if(result.branchList.length==0) {
					$("#select_market_branch_name").val(marketName);
					$("#select_market_branch_name").show();
					$("#search_items_contnr").show();
				} else {
					drawBranchList(result.branchList);
					$("#branch_list").show();
				}
			},
			error: function(request, status, error) {
				console.log(error);
			}
		});
	});
	
	// 지점 검색 목록 호버 이벤트
	$("#branch_list").on("mouseover", "span", function() {
		$(this).parent().children(".marker").css("border-left", "2px solid #03A64A");
	});
	$("#branch_list").on("mouseout", "span", function() {
		$(this).parent().children(".marker").css("border-left", "");
	});
	
	// 지점 검색 목록 클릭 이벤트
	var branchName = "";
	$("#branch_list").on("click", "span", function() {
		$("#branch_list").hide()
	
		branchName = $(this).text();
		
		$("#market_name").val(marketName + " " + branchName);
		$("#select_market_branch_name").val(marketName + " " + branchName);
		$("#select_market_branch_name").show();
		$("#search_items_contnr").show();
	});
	
	// 품목 검색 버튼 클릭 이벤트
	$("#search_items_name").on("keypress", function(event) {
		if(event.keyCode==13) {
			$("#search_items_btn").click();
			return false;
		}
	});
	$("#search_items_btn").on("click", function() {
		// 품목 번호, 이름 초기화
		$("#items_no").val("");
		$("#items_name").val("");
		// 선택 품목 이름 초기화
		$("#select_items_name").val("");
		// 구매량, 금액 초기화
		$("#buy_qnt").val("");
		$("#cost").val("");
		// 레이아웃 초기화
		$("#items_name_contnr, #items_name_contnr > *").hide();
		$("#buy_qnt_cost_contnr").hide();
		
		var params = {
						"marketNo": $("#market_no").val(),
					 	"searchItemsName": $("#search_items_name").val()
					 };
		
		$.ajax({
			url: "searchItemsAjax",
			type: "post",
			dataType: "json",
			data: params,
			success: function(result) {
				drawItemsList(result.itemsList);
				$("#items_list").show();
				$("#items_name_contnr").show();
			},
			error: function(request, status, error) {
				console.log(error);
			}
		});
	});
	
	// 품목 검색 목록 호버 이벤트
	$("#items_list").on("mouseover", "span", function() {
		$(this).parent().children(".marker").css("border-left", "2px solid #03A64A");
	});
	$("#items_list").on("mouseout", "span", function() {
		$(this).parent().children(".marker").css("border-left", "");
	});
	
	// 품목 검색 목록 클릭 이벤트
	var itemsName = "";
	var itemsImgUrl = "";
	$("#items_list").on("click", "span", function() {
		$("#items_list").hide();
		
		$("#items_no").val($(this).parent().attr("items_no"));
		itemsName = $(this).text();
		itemsImgUrl = itemsImgUrlList[$(this).parent().index()];
		
		var params = {
						"marketNo": $("#market_no").val()
					 };
		
		$("#select_items_name").val(itemsName);
		$("#select_items_name").show();
		
		$("#buy_qnt_cost_contnr").show();
	});
	
	// 직접/검색 전환 버튼 클릭 이벤트
	$("#others_item_tag_btn").on("click", function() {
		initItemTagInfo();
			
		if($("#others_item_tag_btn").val()=="직접 입력하기") {
			$("#others_item_tag_btn").attr("gbn", "1");			// 직접
			$("#others_item_tag_btn").css("width", "120px");
			$("#others_item_tag_btn").val("검색으로 입력하기");
			$("#search_market_contnr").hide();
			$("#others_market_name_contnr").show();
			$("#others_items_name_contnr").show();
			$("#buy_qnt_cost_contnr").show();
		} else {
			$("#others_item_tag_btn").attr("gbn", "0");			// 검색
			$("#others_item_tag_btn").css("width", "90px");
			$("#others_item_tag_btn").val("직접 입력하기");
			$("#disct_gbn").val("");
			$("#search_market_name").val("");
			$("#search_market_contnr").show();
			$("#others_market_name_contnr").hide();
			$("#others_items_name_contnr").hide();
			$("#buy_qnt_cost_contnr").hide();
		}
	});
	
	// 가계부 추가 활성화
	$("#add_to_accbk_inactive, #add_to_accbk_btn").on("click", function() {
		$("#add_to_accbk_inactive").hide()
		$("#add_to_accbk_active").show();
		$("#add_to_accbk_btn").addClass("active");
		$("#add_to_accbk_btn").hide();
		$("#buy_date").show();
		$("#add_to_accbk_flag").val("1");
	});
	// 가계부 추가 비활성화
	$("#add_to_accbk_active").on("click", function() {
		$("#add_to_accbk_active").hide();
		$("#add_to_accbk_inactive").show();
		$("#buy_date").val("");
		$("#buy_date").hide();
		$("#add_to_accbk_btn").removeClass("active");
		$("#add_to_accbk_btn").show();
		$("#add_to_accbk_flag").val("0");
	});
	
	// 가계부 추가 구입 일자 input
    $.datepicker.setDefaults({
        dateFormat: 'yy-mm-dd',
        prevText: '이전 달',
        nextText: '다음 달',
        monthNames: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
        monthNamesShort: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
        dayNames: ['일', '월', '화', '수', '목', '금', '토'],
        dayNamesShort: ['일', '월', '화', '수', '목', '금', '토'],
        dayNamesMin: ['일', '월', '화', '수', '목', '금', '토'],
        showMonthAfterYear: true,
        yearSuffix: '년'
    });
	$("#buy_date").datepicker();
	
	// 상품 태그 취소 버튼 클릭 이벤트
	$("#cancel_item_tag_btn").on("click", function() {
		$("#set_item_tag_contnr").hide();
	});
	
	// 상품 태그 등록 버튼 클릭 이벤트
	$("#add_item_tag_btn").on("click", function() {
		var html = "";
		
		if(checkVal("#market_no") && checkVal("#market_name")) {
			alert("마켓을 입력해주세요.");
			if($("#others_item_tag_btn").attr("gbn")=="0") {
				$("#search_market_name").focus();
			} else {
				$("#market_name").focus();
			}
		} else if(checkVal("#items_no") && checkVal("#items_name")) {
			alert("품목을 입력해주세요.");
			if($("#others_item_tag_btn").attr("gbn")=="0") {
				$("#search_items_name").focus();
			} else {
				$("#items_name").focus();
			}
		} else if(checkVal("#buy_qnt")) {
			alert("구매량을 입력해주세요.");
			$("#buy_qnt").focus();
		} else if(checkVal("#cost")) {
			alert("금액을 입력해주세요.");
			$("#cost").focus();
		} else if($("#add_to_accbk_btn").hasClass("active") && checkVal("#buy_date")) {
			alert("구입 일자를 입력해주세요.");
			$("#buy_date").focus();
		} else {
			html += "<li class=\"item_tag\"";
			if($("#market_name").val()=="") {
				html += "market_branch_name=\"" + $("#select_market_branch_name").val() + "\"";
			} else {
				html += "market_branch_name=\"" + $("#market_name").val() + "\"";
			}
			if($("#items_name").val()=="") {
				html += "items_name=\"" + $("#select_items_name").val() + "\"";
			} else {
				html += "items_name=\"" + $("#items_name").val() + "\"";
			}
			html += "buy_qnt=\"" + $("#buy_qnt").val() + "\"";
			html += "cost=\"" + $("#cost").val() + "\">";
			html += "<div class=\"items_img\"></div>";
			html += "<button type=\"button\" class=\"del_item_tag_btn\" style=\"display:none;\">";
			html += "<svg xmlns=\"http://www.w3.org/2000/svg\" width=\"100%\" height=\"100%\" viewBox=\"0 0 24 24\" fill=\"none\" stroke=\"currentColor\" stroke-width=\"2\" stroke-linecap=\"round\" stroke-linejoin=\"round\" class=\"feather feather-x\">";
			html += "<line x1=\"18\" y1=\"6\" x2=\"6\" y2=\"18\"></line>";
			html += "<line x1=\"6\" y1=\"6\" x2=\"18\" y2=\"18\"></line>";
			html += "</svg>";
			html += "</button>";
			html += "</li>";
			
			$(".item_tag_list").eq(diaryImgIdx).append(html);
			
			if(itemsImgUrl!=undefined) {
				$(".item_tag_list").eq(diaryImgIdx).find(".items_img").last().css("background", "center / cover no-repeat "
																									+ " url(\"resources/upload/"
																									+ itemsImgUrl.replace(/\[/g, "%5B").replace(/\]/g, "%5D")
																									+ "\")");
			}
			
			var itemTag = new Object();
			itemTag.marketNo = $("#market_no").val();
			itemTag.itemsNo = $("#items_no").val();
			itemTag.cost = $("#cost").val();
			itemTag.buyQnt = $("#buy_qnt").val();
			itemTag.marketName = $("#market_name").val();
			itemTag.itemsName = $("#items_name").val();
			itemTag.addToAccbkFlag = $("#add_to_accbk_flag").val();
			itemTag.buyDate = $("#buy_date").val();
			
			itemTagArray[diaryImgIdx].push(itemTag);
			
			$("#set_item_tag_contnr").hide();
			// 스크롤바 맨 아래로 내리기
			$("#item_tag_list_contnr").scrollTop($("#item_tag_list_contnr")[0].scrollHeight);
		}
	});
	
	// 태그 호버 이벤트
	$("#item_tag_list_contnr").on("mouseover", "li", function() {
		$(this).children(".del_item_tag_btn").show();
		
		$("#item_tag_dtl_contnr").css("top", $(this).position().top);
		$("#item_tag_dtl_contnr").css("left", $(this).position().left);
		
		$("#item_tag_dtl_market_branch_name").val($(this).attr("market_branch_name"));
		$("#item_tag_dtl_items_name").val($(this).attr("items_name"));
		$("#item_tag_dtl_buy_qnt").val($(this).attr("buy_qnt"));
		$("#item_tag_dtl_cost").val($(this).attr("cost"));
		$("#item_tag_dtl_contnr").css("display", "flex");
	});
	$("#item_tag_list_contnr").on("mouseout", "li", function() {
		$(this).children(".del_item_tag_btn").hide();
		
		$("#item_tag_dtl_contnr").hide();
	});
	
	// 태그 삭제 버튼 클릭 이벤트
	$("#item_tag_list_contnr").on("click", ".del_item_tag_btn", function() {
		$(this).parent().remove();
		itemTagArray[diaryImgIdx].splice($(this).parent().index(), 1);
		
		$("#item_tag_dtl_contnr").hide();
	});
	
	// 내용 박스 크기 내용에 따라 동적으로 변화
	$("#diary_con").on("keyup", function() {
		autosize($(this));
	});
	
	// 일기 올리기 버튼 클릭 이벤트
	$("#write_diary_btn").on("click", function() {
		var params = {
						"memberNo": $("#member_no").val(),
					 	"diaryImgList": JSON.stringify(diaryImgArray),
					 	"itemTagList": JSON.stringify(itemTagArray),
					 	"con": $("#diary_con").val()
					 };
		
		$.ajax({
			url: "writeDiaryAjax",
			type: "post",
			dataType: "json",
			data: params,
			success: function(result) {
				if(result.msg=="SUCCESS") {
					alert("일기 올리기에 성공하였습니다.");
					location.href = "home";
				} else if(result.msg=="FAILED") {
					alert("일기 올리기에 실패하였습니다.");
				} else {
					alert("일기 올리기 중 문제가 발생하였습니다.");
				}
			},
			error: function(request, status, error) {
				console.log(error);
			}
		});
	});
	
	// 일기 취소 버튼 클릭 이벤트 /////////////////////////////////
});



// input 값 확인
function checkVal(input) {
	if($.trim($(input).val()) == "") {
		return true;
	} else {
		return false;
	}
}

// 슬라이드 출력
function showSlide(diaryImgIdx) {
	if($("#diary_img_list li").length==0) {
		$("#no_diary_img_btn").show();
		
		$("#previous_slide_btn").hide();
		$("#next_slide_btn").hide();
		
		$("#change_diary_img_btn").hide();
		$("#del_diary_img_btn").hide();
		
		$("#edit_item_tag_btn").hide();
	} else if($("#diary_img_list li").length==1) {
		$("#no_diary_img_btn").hide();
		
		$("#previous_slide_btn").hide();
		$("#next_slide_btn").hide();
		
		$("#change_diary_img_btn").show();
		$("#del_diary_img_btn").show();
		
		$("#edit_item_tag_btn").show();
	} else {
		$("#no_diary_img_btn").hide();
		
		if(diaryImgIdx==0) {
			$("#previous_slide_btn").hide();
		} else {
			$("#previous_slide_btn").show();
		}
		if(diaryImgIdx==$("#diary_img_list li").length - 1) {
			$("#next_slide_btn").hide();
		} else {
			$("#next_slide_btn").show();
		}
		
		$("#change_diary_img_btn").show();
		$("#del_diary_img_btn").show();
		
		$("#edit_item_tag_btn").show();
	}
	
	$("#diary_img_list > li").hide();
	$("#diary_img_list > li").eq(diaryImgIdx).show();
	
	$(".item_tag_list").hide();
	$(".item_tag_list").eq(diaryImgIdx).show();
}

// 태그 설정창 초기화
function initItemTagInfo() {
	// 마켓 번호, 이름 초기화
	$("#market_no").val("");
	$("#market_name").val("");
	// 품목 번호, 이름 초기화
	$("#items_no").val("");
	$("#items_name").val("");
	// 품목 검색 초기화
	$("#search_items_name").val("");
	// 선택 마켓 이름, 선택 품목 이름 초기화
	$("#select_market_branch_name").val("");
	$("#select_items_name").val("");
	// 구매량, 금액 초기화
	$("#buy_qnt").val("");
	$("#cost").val("");
	// 레이아웃 초기화
	$("#market_branch_name_contnr, #market_branch_name_contnr > *").hide();
	$("#search_items_contnr").hide();
	$("#items_name_contnr, #items_name_contnr > *").hide();
	$("#buy_qnt_cost_contnr").hide();
}

// 지역구 목록 그리기
function drawDisctList(disctList) {
	var html = "";
	
	html += "<option value=\"\" selected disabled hidden>- 지역구 -</option>";
	for(var data of disctList) {
		html += "<option value=\"" + data.DISCT_NO + "\">" + data.DISCT_NAME + "</option>";
	}
	
	$("#disct_gbn").html(html);
}

// 마켓 검색 결과 그리기
function drawMarketList(marketList) {
	var html = "";
	
	for(var data of marketList) {
		html += "<li market_no=\"" + data.MARKET_NO + "\">"
		html += "	<div class=\"marker\"></div><span>" + data.MARKET_NAME + "</span>"
		html += "</li>";
	}
	
	$("#market_list").html(html);
}

// 지점 검색 결과 그리기
function drawBranchList(branchList) {
	var html = "";
	
	for(var data of branchList) {
		html += "<li>"
		html += "	<div class=\"marker\"></div><span>" + data.BRANCH_NAME + "</span>"
		html += "</li>";
	}
	
	$("#branch_list").html(html);
}

// 품목 검색 결과 그리기
var itemsImgUrlList;
function drawItemsList(itemsList) {
	var html = "";
	
	itemsImgUrlList = new Array();
	for(var data of itemsList) {
		html += "<li items_no=\"" + data.ITEMS_NO + "\">"
		html += "	<div class=\"marker\"></div><span>" + data.ITEMS_NAME + "</span>"
		html += "</li>";
		
		itemsImgUrlList.push(data.IMG_URL);
	}
	
	$("#items_list").html(html);
}