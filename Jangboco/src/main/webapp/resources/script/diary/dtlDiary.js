$(document).ready(function() {
	loadDiaryImgItemTag();
	loadDiaryData();
	checkDiaryLike();
	loadProfileDiaryList();
	loadHastgList();
	loadComntList();
	$("#comnt_list").animate({scrollTop: $("#comnt_list")[0].scrollHeight}, 500);

	var diaryImgIdx = 0;

	// 슬라이드 전/후 버튼 클릭 이벤트
	$("#previous_slide_btn").on("click", function() {
		showSlide(diaryImgIdx -= 1);
	});
	$("#next_slide_btn").on("click", function() {
		showSlide(diaryImgIdx += 1);
	});
	
	// 좋아요 버튼 클릭 이벤트
	$("#unlike_icon, #like_icon").on("click", function() {
		if($("#member_no").val()=="") {
			return false;
		}
		
		diaryLikeUnlike();
	});
	
	// 신고 버튼 클릭 이벤트
	$("#diary_accuse_btn").on("click", function() {
		if($("#member_no").val()=="") {
			return false;
		}
		
		if($("#diary_accuse_info_contnr").css("display")=="none") {
			resetAccuse($("#diary_accuse_info_contnr"));
			$("#diary_accuse_info_contnr").fadeIn(200);
		}
	});
	
	// 신고 접수 버튼 클릭 이벤트
	$("#diary_accuse_submit_btn").on("click", function() {
		if(checkVal("#diary_accuse_title")) {
			alert("신고 제목을 입력하세요.");
			$("#diary_accuse_title").focus();
		} else if(checkVal("#diary_accuse_reason_code")) {
			alert("신고 사유를 선택해주세요.");
			$("#diary_accuse_reason_code").focus();
		} else if(checkVal("#diary_accuse_con")) {
			alert("신고 내용을 작성해주세요.");
			$("#diary_accuse_con").focus();
		} else {
			var params = {
							"diaryNo": $("#diary_no").val(),
							"memberNo": $("#member_no").val(),
							"reasonCode": $("#diary_accuse_reason_code").val(),
							"title": $("#diary_accuse_title").val(),
							"con": $("#diary_accuse_con").val()
					 	 };
					 
			$.ajax({
				url: "diaryAccuseAjax",
				type: "post",
				dataType: "json",
				data: params,
				success: function(result) {
					if(result.msg=="SUCCESS") {
						alert("신고가 정상적으로 접수되었습니다.");
						$("#diary_accuse_info_contnr").fadeOut(200);
					} else if (result.msg=="FAILED") {
						alert("신고 접수에 실패하였습니다.");
					} else {
						alert("신고 접수 중 문제가 발생하였습니다.");
					}
				},
				error: function(request, status, error) {
					console.log(error);
				}
			});
		}
	})
	
	// 신고 취소 버튼 클릭 이벤트
	$("#diary_accuse_cancel_btn").on("click", function() {
		$("#diary_accuse_info_contnr").fadeOut(200);
	});
	
	// 프로필 사진, 닉네임 클릭 이벤트
	$("#profile_img, #nicnm").on("click", function() {
		$("#action_form").attr("action", "diaryPernlPage");
		$("#action_form").submit();
	});
	
	// 팔로우 버튼 클릭 이벤트
	$("#img_nicnm_folw_btn_contnr").on("click", "#folw_btn", function() {
		if($("#member_no").val()=="") {
			return false;
		}
		
		DiaryFolwUnfolw();
	});
	
	// 일기 수정 버튼 클릭 이벤트
	$("#img_nicnm_folw_btn_contnr").on("click", "#diary_update_btn", function() {
		$("#action_form").attr("action", "updateDiary");
		$("#action_form").submit();
	});
	
	// 일기 삭제 버튼 클릭 이벤트
	$("#img_nicnm_folw_btn_contnr").on("click", "#diary_delete_btn", function() {
		if(confirm("일기를 삭제하시겠습니까?")) {
			var params = {
							"diaryNo": $("#diary_no").val(),
						 };
			
			$.ajax({
				url: "deleteDiaryAjax",
				type: "post",
				dataType: "json",
				data: params,
				success: function(result) {
					if(result.msg=="SUCCESS") {
						alert("일기 삭제에 성공하였습니다.");
						location.href = "diaryMain";
					} else if(result.msg=="FAILED") {
						alert("일기 삭제에 실패하였습니다.");
					} else {
						alert("일기 삭제 중 문제가 발생하였습니다.");
					}
				},
				error: function(request, status, error) {
					console.log(error);
				}
			});
		}
	});
	
	// 프로필 일기 목록 클릭 이벤트
	$("#profile_diary_img_list").on("click", "li", function() {
		$("#diary_no").val($(this).attr("diary_no"));
		$("#prev_home_flag").val($("#home_flag").val());
		$("#prev_menu_idx").val($("#menu_idx").val());
		$("#prev_sub_menu_idx").val($("#sub_menu_idx").val());
		
		$("#action_form").attr("action", "dtlDiary");
		$("#action_form").submit();
	});
	
	// 태그 호버 이벤트
	$("#item_tag_list_contnr").on("mouseenter", "li", function() {
		$(this).children(".del_item_tag_btn").show();
		
		$("#item_tag_dtl_contnr").css("top", $(this).position().top);
		$("#item_tag_dtl_contnr").css("left", $(this).position().left);
		
		$("#item_tag_dtl_market_branch_name").val($(this).attr("market_branch_name"));
		$("#item_tag_dtl_items_name").val($(this).attr("items_name"));
		$("#item_tag_dtl_buy_qnt").val($(this).attr("buy_qnt"));
		$("#item_tag_dtl_cost").val($(this).attr("cost"));
		$("#item_tag_dtl_contnr").fadeIn(100);
	});
	$("#item_tag_list_contnr").on("mouseleave", "li", function() {
		$(this).children(".del_item_tag_btn").hide();
		
		$("#item_tag_dtl_contnr").hide();
	});
	
	// 답글 달기/취소 버튼 클릭 이벤트
	$("#comnt_list").on("click", ".recomnt_btn", function() {
		var add_recomnt_contnr = $(this).parent().parent().children(".add_recomnt_contnr");
		
		if(add_recomnt_contnr.css("display")=="none") {
			$(this).val("답글 취소");
			add_recomnt_contnr.children("textarea").val("");
			add_recomnt_contnr.fadeIn(100);
			add_recomnt_contnr.children("textarea").focus();
		} else {
			$(this).val("답글 달기");
			add_recomnt_contnr.fadeOut(100);
		}
	});
	
	// 답글 목록 보기/숨기기
	$("#comnt_list").on("click", ".toggle_recomnt_btn", function() {
		var comnt = $(this).parent().parent();
		var recomntNum = cntRecomnt(comnt);
		var recomnt_list = $(this).parent().children(".recomnt_list");
		
		if(recomntNum==0) {
			$(this).hide();
		} else {
			if(recomnt_list.css("display")=="none") {
				recomnt_list.slideDown(200, "swing");
				$(this).val("답글 숨기기");
			} else {
				recomnt_list.slideUp(200, "swing");
				$(this).val("답글 " + recomntNum + "개 보기");
			}
		}
	});
	
	// 댓글 등록 버튼 클릭 이벤트
	$("#comnt_list_add_comnt_contnr").on("keypress", "textarea", function(event) {
		if(event.keyCode==13) {
			$(this).parent().children(".add_comnt_btn").click();
			return false;
		}
	});
	$("#comnt_list_add_comnt_contnr").on("click", ".add_comnt_btn", function() {
		if($("#member_no").val()=="") {
			return false;
		}
		
		var con = $(this).parent().children("textarea");
		
		if($.trim(con.val())=="") {
			alert("댓글 내용을 입력하세요.");
			con.focus();
		} else {
			var parentComntNo = $(this).parent().parent().parent().attr("comnt_no");
			if(parentComntNo==undefined) {
				parentComntNo = "";
			}
			
			var params = {
							"diaryNo": $("#diary_no").val(),
							"memberNo": $("#member_no").val(),
							"parentComntNo": parentComntNo,
							"con": con.val()
			 			 };
						 
			$.ajax({
				url: "addComntAjax",
				type: "post",
				dataType: "json",
				data: params,
				success: function(result) {
					if(result.msg=="SUCCESS") {
						con.val("");
						loadComntList();
						var addedComnt;
						if(parentComntNo!="") {
							var parentComnt = $("#comnt_list > li[comnt_no=" + parentComntNo + "]");
							var addedRecomntList = parentComnt.find(".recomnt_list");
							var addedRecomnt = addedRecomntList.children("li").last();
							addedComnt = addedRecomnt;
							
							parentComnt.find(".toggle_recomnt_btn").val("답글 숨기기");
							addedRecomntList.show();
							
							var totalHeight = 0;
							for(var i=0; i<$("#comnt_list > li").length; i++) {
								totalHeight += $("#comnt_list > li").eq(i).height() + 5;
							}
							var nowHeight = 0;
							for(var i=0; i<$("#comnt_list > li").length; i++) {
								nowHeight += $("#comnt_list > li").eq(i).height() + 5;
								
								if($("#comnt_list > li").eq(i).attr("comnt_no")==parentComntNo) {
									break;
								}
							}
							nowHeight -= 215;
							$("#comnt_list").animate({scrollTop: $("#comnt_list")[0].scrollHeight * nowHeight / totalHeight}, 500);
						} else {
							addedComnt = $("#comnt_list > li").last();
							
							$("#add_comnt_con").css("height", "auto");
							$("#comnt_list").animate({scrollTop: $("#comnt_list")[0].scrollHeight}, 500);
						}
						addedComnt.find(".comnt_con_contnr").animate({backgroundColor: "#03A64AAA"}, 800).animate({backgroundColor: "#FFFFFF"}, 600);
					} else if (result.msg=="FAILED") {
						alert("댓글 등록에 실패하였습니다.");
					} else {
						alert("댓글 등록 중 문제가 발생하였습니다.");
					}
				},
				error: function(request, status, error) {
					console.log(error);
				}
			});
		}
	});
	
	// 댓글 박스 크기 내용에 따라 동적으로 변화
	$("#add_comnt_con").on("keyup", function() {
		autosize($(this));
	});
	
	// 댓글 좋아요 버튼 클릭 이벤트
	$("#comnt_list").on("click", ".unlike_icon, .like_icon ", function() {
		if($("#member_no").val()=="") {
			return false;
		}
		
		var comnt = $(this).parent().parent().parent().parent()
		
		comntLikeUnlike(comnt);
	});
	
	// 댓글 신고 버튼 클릭 이벤트
	$("#comnt_list").on("click", ".comnt_accuse_btn", function() {
		if($("#member_no").val()=="") {
			return false;
		}
		
		if($("#comnt_accuse_info_contnr").css("display")=="none") {
			$("#accuse_comnt_no").val($(this).parent().parent().parent().parent().attr("comnt_no"));
			resetAccuse($("#comnt_accuse_info_contnr"));
			$("#comnt_accuse_info_contnr").fadeIn(200);
		}
	});
	
	// 댓글 신고 접수 버튼 클릭 이벤트
	$("#comnt_accuse_submit_btn").on("click", function() {
		if($("#member_no").val()=="") {
			return false;
		}
		
		if(checkVal("#comnt_accuse_title")) {
			alert("신고 제목을 입력하세요.");
			$("#comnt_accuse_title").focus();
		} else if(checkVal("#comnt_accuse_reason_code")) {
			alert("신고 사유를 선택해주세요.");
			$("#comnt_accuse_reason_code").focus();
		} else if(checkVal("#comnt_accuse_con")) {
			alert("신고 내용을 작성해주세요.");
			$("#comnt_accuse_con").focus();
		} else {
			var params = {
							"comntNo": $("#accuse_comnt_no").val(),
							"memberNo": $("#member_no").val(),
							"reasonCode": $("#comnt_accuse_reason_code").val(),
							"title": $("#comnt_accuse_title").val(),
							"con": $("#comnt_accuse_con").val()
					 	 };
					 
			$.ajax({
				url: "comntAccuseAjax",
				type: "post",
				dataType: "json",
				data: params,
				success: function(result) {
					if(result.msg=="SUCCESS") {
						alert("신고가 정상적으로 접수되었습니다.");
						$("#comnt_accuse_info_contnr").fadeOut(200);
					} else if (result.msg=="FAILED") {
						alert("신고 접수에 실패하였습니다.");
					} else {
						alert("신고 접수 중 문제가 발생하였습니다.");
					}
				},
				error: function(request, status, error) {
					console.log(error);
				}
			});
		}
	})
	
	// 댓글 신고 취소 버튼 클릭 이벤트
	$("#comnt_accuse_cancel_btn").on("click", function() {
		$("#comnt_accuse_info_contnr").fadeOut(200);
	});
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
	$("#diary_img_list > li").eq(diaryImgIdx).fadeIn(600);
	
	$(".item_tag_list").hide();
	$(".item_tag_list").eq(diaryImgIdx).show();
}

// 일기사진, 상품태그 로드
function loadDiaryImgItemTag() {
	var params = {
					"diaryNo": $("#diary_no").val()
				 };
	
	$.ajax({
		url: "getDiaryImgItemTagAjax",
		type: "post",
		dataType: "json",
		data: params,
		success: function(result) {
			drawDiaryImgItemTag(result.diaryImgList);
			showSlide(0);
		},
		error: function(request, status, error) {
			console.log(error);
		}
	});
}

// 일기사진, 상품태그 그리기
function drawDiaryImgItemTag(diaryImgList) {
	var diaryImgHtml = "";
	var itemTagHtml = "";
	
	for(var diaryImgData of diaryImgList) {
		diaryImgHtml += "<li>";
		diaryImgHtml += "	<div class=\"diary_img\" style=\"background:center / cover no-repeat url('resources/upload/";
		diaryImgHtml += 	diaryImgData.IMG_URL.replace(/\[/g, "%5B").replace(/\]/g, "%5D") + "');\">";
		diaryImgHtml += "	</div>";
		diaryImgHtml += "</li>";
		
		itemTagHtml += "<ul class=\"item_tag_list\">";
		for(var itemTagData of diaryImgData.itemTagList) {
			itemTagHtml += "<li class=\"item_tag\" ";
			if(itemTagData.MARKET_NO!=undefined) {
				itemTagHtml += " market_no=\"" + itemTagData.MARKET_NO + "\" ";
			} else {
				itemTagHtml += " market_no=\"\" ";
			}
			itemTagHtml += " market_branch_name=\"" + itemTagData.MARKET_NAME + "\" ";
			if(itemTagData.ITEMS_NO!=undefined) {
				itemTagHtml += " items_no=\"" + itemTagData.ITEMS_NO + "\" ";
			} else {
				itemTagHtml += " items_no=\"\" ";
			}
			itemTagHtml += " items_name=\"" + itemTagData.ITEMS_NAME + "\" ";
			itemTagHtml += " buy_qnt=\"" + itemTagData.BUY_QNT + "\" ";
			itemTagHtml += " cost=\"" + itemTagData.COST + "\">";
			itemTagHtml += "	<div class=\"items_img\" ";
			if(itemTagData.IMG_URL!=undefined) {
				itemTagHtml += " style=\"background:center / cover no-repeat url('resources/upload/";
				itemTagHtml += itemTagData.IMG_URL.replace(/\[/g, "%5B").replace(/\]/g, "%5D") + "');\">";
			}
			itemTagHtml += "	></div>";
			itemTagHtml += "</li>";
		}
		itemTagHtml += "</ul>";
	}
	
	$("#diary_img_list").html(diaryImgHtml);
	$("#item_tag_list_contnr").html(itemTagHtml);
}


// 일기 정보 로드
function loadDiaryData() {
	var params = {
					"diaryNo": $("#diary_no").val()
				 };
	
	$.ajax({
		url: "getDiaryDataAjax",
		type: "post",
		dataType: "json",
		data: params,
		success: function(result) {
			$("#diary_member_no").val(result.diaryData.MEMBER_NO);
			$("#like").text("좋아요 " + result.diaryData.DIARY_LIKE + "개");
			$("#diary_con").text(result.diaryData.CON);
			if(result.diaryData.IMG_URL!=undefined) {
				$("#profile_img").css("background", "center / cover no-repeat "
													+ " url(\"resources/upload/"
													+ result.diaryData.IMG_URL.replace(/\[/g, "%5B").replace(/\]/g, "%5D")
													+ "\")");
			}
			$("#nicnm").text(result.diaryData.NICNM);
			
			if($("#member_no").val()==result.diaryData.MEMBER_NO) {
				$("#img_nicnm_folw_btn_contnr").append("<input type=\"button\" id=\"diary_update_btn\" class=\"diary_update_btn\" value=\"수정\">");
				$("#img_nicnm_folw_btn_contnr").append("<input type=\"button\" id=\"diary_delete_btn\" class=\"diary_delete_btn\" value=\"삭제\">");
			} else {
				$("#img_nicnm_folw_btn_contnr").append("<input type=\"button\" id=\"folw_btn\" class=\"folw_btn\">");
				checkDiaryFolw();
			}
		},
		error: function(request, status, error) {
			console.log(error);
		}
	});
}

// 좋아요 여부
function checkDiaryLike() {
	var params = {
					"memberNo": $("#member_no").val(),
					"diaryNo": $("#diary_no").val()
				 };
	
	$.ajax({
		url: "checkDiaryLikeAjax",
		type: "post",
		dataType: "json",
		data: params,
		success: function(result) {
			if(result.checkDiaryLike==0) {
				$("#like_icon").hide();
				$("#unlike_icon").show();
			} else {
				$("#unlike_icon").hide();
				$("#like_icon").show();
			}
		},
		error: function(request, status, error) {
			console.log(error);
		}
	});
}

// 좋아요 개수
function cntDiaryLike() {
	var params = {
					"diaryNo": $("#diary_no").val()
				 };
	
	$.ajax({
		url: "cntDiaryLikeAjax",
		type: "post",
		dataType: "json",
		data: params,
		success: function(result) {
			$("#like").text("좋아요 " + result.cntDiaryLike + "개");
		},
		error: function(request, status, error) {
			console.log(error);
		}
	});
}

// 좋아요 하기/취소
function diaryLikeUnlike() {
	var params = {
					"memberNo": $("#member_no").val(),
					"diaryNo": $("#diary_no").val()
				 };
	
	$.ajax({
		url: "checkDiaryLikeAjax",
		type: "post",
		dataType: "json",
		data: params,
		success: function(result) {
			if(result.checkDiaryLike==0) {
				diaryLike();
			} else {
				diaryUnlike();
			}
		},
		error: function(request, status, error) {
			console.log(error);
		}
	});
}

// 좋아요 하기
function diaryLike() {
	var params = {
					"memberNo": $("#member_no").val(),
					"diaryNo": $("#diary_no").val()
				 };
	
	$.ajax({
		url: "diaryLikeAjax",
		type: "post",
		dataType: "json",
		data: params,
		success: function(result) {
			$("#unlike_icon").hide();
			$("#like_icon").show();
			cntDiaryLike();
		},
		error: function(request, status, error) {
			console.log(error);
		}
	});
}

// 좋아요 취소
function diaryUnlike() {
	var params = {
					"memberNo": $("#member_no").val(),
					"diaryNo": $("#diary_no").val()
				 };
	
	$.ajax({
		url: "diaryUnlikeAjax",
		type: "post",
		dataType: "json",
		data: params,
		success: function(result) {
			$("#like_icon").hide();
			$("#unlike_icon").show();
			cntDiaryLike();
		},
		error: function(request, status, error) {
			console.log(error);
		}
	});
}

// 팔로우 여부
function checkDiaryFolw() {
	var params = {
					"memberNo": $("#member_no").val(),
					"diaryNo": $("#diary_no").val()
				 };
	
	$.ajax({
		url: "checkDiaryFolwAjax",
		type: "post",
		dataType: "json",
		data: params,
		success: function(result) {
			if(result.checkDiaryFolw==0) {
				$("#folw_btn").val("팔로우");
			} else {
				$("#folw_btn").val("팔로잉");
			}
		},
		error: function(request, status, error) {
			console.log(error);
		}
	});
}

// 팔로우 하기/취소
function DiaryFolwUnfolw() {
	var params = {
					"memberNo": $("#member_no").val(),
					"diaryNo": $("#diary_no").val()
				 };
	
	$.ajax({
		url: "checkDiaryFolwAjax",
		type: "post",
		dataType: "json",
		data: params,
		success: function(result) {
			if(result.checkDiaryFolw==0) {
				diaryFolw();
			} else {
				diaryUnfolw();
			}
		},
		error: function(request, status, error) {
			console.log(error);
		}
	});
}

// 팔로우 하기
function diaryFolw() {
	var params = {
					"reqMemberNo": $("#member_no").val(),
					"targetMemberNo": $("#diary_member_no").val()
				 };
	
	$.ajax({
		url: "diaryFolwAjax",
		type: "post",
		dataType: "json",
		data: params,
		success: function(result) {
			checkDiaryFolw();
		},
		error: function(request, status, error) {
			console.log(error);
		}
	});
}

// 팔로우 취소
function diaryUnfolw() {
	var params = {
					"reqMemberNo": $("#member_no").val(),
					"targetMemberNo": $("#diary_member_no").val()
				 };
	
	$.ajax({
		url: "diaryUnfolwAjax",
		type: "post",
		dataType: "json",
		data: params,
		success: function(result) {
			$("#folw_btn").val("팔로우");
		},
		error: function(request, status, error) {
			console.log(error);
		}
	});
}

// 신고창 초기화
function resetAccuse(accuseInfoContnr) {
	accuseInfoContnr.children(".accuse_title").val("");
	accuseInfoContnr.children(".accuse_reason_code").val("");
	accuseInfoContnr.children(".accuse_con").val("");
}

// 프로필 일기 목록 로드
function loadProfileDiaryList() {
	var params = {
					"diaryNo": $("#diary_no").val()
				 };
	
	$.ajax({
		url: "getProfileDairyListAjax",
		type: "post",
		dataType: "json",
		data: params,
		success: function(result) {
			for(var i=0; i<result.profileDiaryList.length; i++) {
				$("#profile_diary_img_list").append("<li diary_no=\"" + result.profileDiaryList[i].DIARY_NO + "\"><div class=\"profile_diary_img\"></div></li>");
				$("#profile_diary_img_list > li").last().children(".profile_diary_img").css("background", "center / cover no-repeat "
															+ " url(\"resources/upload/"
															+ result.profileDiaryList[i].IMG_URL.replace(/\[/g, "%5B").replace(/\]/g, "%5D")
															+ "\")");
			}
		},
		error: function(request, status, error) {
			console.log(error);
		}
	});
}

// 해시태그 목록 그리기
function drawHastgList(hastgList) {
	var html = "";

	for(var hastgData of hastgList) {
		html += "<li hastg_no=\"" + hastgData.HASTG_NO + "\">";
		html += "<span class=\"hastg\">" + hastgData.HASTG_NAME + "</span>";
		html += "</li>";
	}
	
	$("#hastg_list").html(html);
}

// 해시태그 목록 로드
function loadHastgList() {
	var params = {
					"diaryNo": $("#diary_no").val()
				 };
	
	$.ajax({
		url: "getHastgListAjax",
		type: "post",
		dataType: "json",
		data: params,
		success: function(result) {
			drawHastgList(result.hastgList);
		},
		error: function(request, status, error) {
			console.log(error);
		}
	});
}

// 댓글창 그리기
function drawComntList(comntList, recomntList) {
	$("#comnt_list").empty();
	
	for(var comntData of comntList) {
		var comntHtml = "";
		
		comntHtml += "<li comnt_no=\"" + comntData.COMNT_NO + "\">";
		comntHtml += "	<div class=\"profile_img\"></div>";
		comntHtml += "	<div class=\"comnt_contnr\">";
		comntHtml += "		<div class=\"nicnm_con_like_accuse_contnr\">";
		comntHtml += "			<div class=\"comnt_con_contnr\">";
		comntHtml += "				<span class=\"comnt_nicnm\">" + comntData.NICNM + "</span>";
		comntHtml += "				<span class=\"comnt_con\">" + comntData.CON + "</span>";
		comntHtml += "			</div>";
		comntHtml += "			<div class=\"like_accuse_contnr\">";
		comntHtml += "				<div class=\"unlike_icon\" style=\"display:block;\"></div>";
		comntHtml += "				<div class=\"like_icon\"></div>";
		comntHtml += "				<input type=\"button\" class=\"comnt_accuse_btn\" value=\"신고\">";
		comntHtml += "			</div>";
		comntHtml += "		</div>";
		comntHtml += "		<div class=\"comnt_btn_contnr\">";
		comntHtml += "			<span class=\"comnt_date\">" + comntData.COMNT_DATE + "</span>";
		comntHtml += "			<span class=\"like\">" + "좋아요 " + comntData.COMNT_LIKE + "개" + "</span>";
		comntHtml += "			<input type=\"button\" class=\"recomnt_btn\" value=\"답글 달기\">";
		comntHtml += "		</div>";
		
		if(comntData.recomntList.length > 0) {
			comntHtml += "	<input type=\"button\" class=\"toggle_recomnt_btn\" value=\"답글 " + comntData.recomntList.length + "개 보기\">";
		}
		
			comntHtml += "	<div class=\"add_recomnt_contnr\" style=\"display:none;\">";
			comntHtml += "		<textarea class=\"add_recomnt_con\"></textarea>";
			comntHtml += "		<input type=\"button\" class=\"add_comnt_btn\" value=\"답글 등록\">";
			comntHtml += "	</div>";
		
		if(comntData.recomntList.length > 0) {
			comntHtml += "	<ul class=\"recomnt_list\" style=\"display:none;\">";
			comntHtml += "	</ul>";
		}
		
		comntHtml += "	</div>";
		comntHtml += "</li>";
		
		$("#comnt_list").append(comntHtml);
		var comnt = $("#comnt_list > li").last();
		checkComntLike(comnt);
		
		for(var recomntData of comntData.recomntList) {
			var recomntHtml = "";
			
			recomntHtml += "<li comnt_no=\"" + recomntData.COMNT_NO + "\">";
			recomntHtml += "	<div class=\"profile_img\"></div>";
			recomntHtml += "	<div class=\"comnt_contnr\">";
			recomntHtml += "		<div class=\"nicnm_con_like_accuse_contnr\">";
			recomntHtml += "			<div class=\"comnt_con_contnr\">";
			recomntHtml += "				<span class=\"comnt_nicnm\">" + recomntData.NICNM + "</span>";
			recomntHtml += "				<span class=\"comnt_con\">" + recomntData.CON + "</span>";
			recomntHtml += "			</div>";
			recomntHtml += "			<div class=\"like_accuse_contnr\">";
			recomntHtml += "				<div class=\"unlike_icon\" style=\"display:block;\"></div>";
			recomntHtml += "				<div class=\"like_icon\"></div>";
			recomntHtml += "				<input type=\"button\" class=\"comnt_accuse_btn\" value=\"신고\">";
			recomntHtml += "			</div>";
			recomntHtml += "		</div>";
			recomntHtml += "		<div class=\"comnt_btn_contnr\">";
			recomntHtml += "			<span class=\"comnt_date\">" + recomntData.COMNT_DATE + "</span>";
			recomntHtml += "			<span class=\"like\">" + "좋아요 " + recomntData.COMNT_LIKE + "개" + "</span>";
			recomntHtml += "		</div>";
			recomntHtml += "	</div>";
			recomntHtml += "</li>";
			
			comnt.find(".recomnt_list").append(recomntHtml);
			var recomnt = comnt.find(".recomnt_list > li").last();
			checkComntLike(recomnt);
		}
	}
}

// 댓글창 로드
function loadComntList() {
	var params = {
					"diaryNo": $("#diary_no").val()
				 };
	
	$.ajax({
		url: "getComntListAjax",
		type: "post",
		dataType: "json",
		data: params,
		async: false,
		success: function(result) {
			drawComntList(result.comntList);
		},
		error: function(request, status, error) {
			console.log(error);
		}
	});
}

// 답글 개수
function cntRecomnt(comnt) {
	var recomntNum;
	
	var params = {
					"parentComntNo": comnt.attr("comnt_no")
	}
	
		$.ajax({
		url: "cntRecomntAjax",
		type: "post",
		dataType: "json",
		data: params,
		async: false,
		success: function(result) {
			recomntNum = result.cntRecomnt;
		},
		error: function(request, status, error) {
			console.log(error);
		}
	});
	
	return recomntNum;
}

// 댓글 좋아요 여부
function checkComntLike(comnt) {
	var params = {
					"memberNo": $("#member_no").val(),
					"comntNo": comnt.attr("comnt_no")
				 };
	
	$.ajax({
		url: "checkComntLikeAjax",
		type: "post",
		dataType: "json",
		data: params,
		success: function(result) {
			if(result.checkComntLike==0) {
				comnt.children().children().find(".like_icon").hide();
				comnt.children().children().find(".unlike_icon").show();
			} else {
				comnt.children().children().find(".unlike_icon").hide();
				comnt.children().children().find(".like_icon").show();
			}
		},
		error: function(request, status, error) {
			console.log(error);
		}
	});
}

// 댓글 좋아요 개수
function cntComntLike(comnt) {
	var params = {
					"comntNo": comnt.attr("comnt_no")
				 };
	
	$.ajax({
		url: "cntComntLikeAjax",
		type: "post",
		dataType: "json",
		data: params,
		success: function(result) {
			comnt.children(".comnt_contnr").children(".comnt_btn_contnr").children(".like").text("좋아요 " + result.cntComntLike + "개");
		},
		error: function(request, status, error) {
			console.log(error);
		}
	});
}

// 댓글 좋아요 하기/취소
function comntLikeUnlike(comnt) {
	var params = {
					"memberNo": $("#member_no").val(),
					"comntNo": comnt.attr("comnt_no")
				 };
	
	$.ajax({
		url: "checkComntLikeAjax",
		type: "post",
		dataType: "json",
		data: params,
		success: function(result) {
			if(result.checkComntLike==0) {
				comntLike(comnt);
			} else {
				comntUnlike(comnt);
			}
		},
		error: function(request, status, error) {
			console.log(error);
		}
	});
}

// 댓글 좋아요 하기
function comntLike(comnt) {
	var params = {
					"memberNo": $("#member_no").val(),
					"comntNo": comnt.attr("comnt_no")
				 };
	
	$.ajax({
		url: "comntLikeAjax",
		type: "post",
		dataType: "json",
		data: params,
		success: function(result) {
			comnt.children().children().find(".unlike_icon").hide();
			comnt.children().children().find(".like_icon").show();
			cntComntLike(comnt);
		},
		error: function(request, status, error) {
			console.log(error);
		}
	});
}

// 댓글 좋아요 취소
function comntUnlike(comnt) {
	var params = {
					"memberNo": $("#member_no").val(),
					"comntNo": comnt.attr("comnt_no")
				 };
	
	$.ajax({
		url: "comntUnlikeAjax",
		type: "post",
		dataType: "json",
		data: params,
		success: function(result) {
			comnt.children().children().find(".like_icon").hide();
			comnt.children().children().find(".unlike_icon").show();
			cntComntLike(comnt);
		},
		error: function(request, status, error) {
			console.log(error);
		}
	});
}