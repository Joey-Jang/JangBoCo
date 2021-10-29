$(document).ready(function() {
	loadDiaryImgItemTag();
	loadDiaryData();
	checkDiaryLike();
	loadProfileDiaryList();
	checkFolw();
	loadHastgList();

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
		diaryLikeUnlike();
	});
	
	// 신고 버튼 클릭 이벤트
	$("#accuse_btn").on("click", function() {
		if($("#accuse_info_contnr").css("display")=="none") {
			resetAccuse();
			$("#accuse_info_contnr").fadeIn(200);
		}
	});
	
	// 신고 접수 버튼 클릭 이벤트
	$("#accuse_submit_btn").on("click", function() {
		if(checkVal("#title")) {
			alert("신고 제목을 입력하세요.");
			$("#title").focus();
		} else if(checkVal("#reason_code")) {
			alert("신고 사유를 선택해주세요.");
			$("#reason_code").focus();
		} else if(checkVal("#accuse_con")) {
			alert("신고 내용을 작성해주세요.");
			$("#accuse_con").focus();
		} else {
			var params = {
							"diaryNo": $("#diary_no").val(),
							"memberNo": $("#member_no").val(),
							"reasonCode": $("#reason_code").val(),
							"title": $("#title").val(),
							"con": $("#accuse_con").val()
					 	 };
					 
			$.ajax({
				url: "diaryAccuseAjax",
				type: "post",
				dataType: "json",
				data: params,
				success: function(result) {
					if(result.msg=="SUCCESS") {
						alert("신고가 정상적으로 접수되었습니다.");
						$("#accuse_info_contnr").fadeOut(200);
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
	$("#accuse_cancel_btn").on("click", function() {
		$("#accuse_info_contnr").fadeOut(200);
	});
	
	// 프로필 사진, 닉네임 클릭 이벤트 //////////////////////////////////////////////////
	$("#profile_img, #nicnm").on("click", function() {
	});
	
	// 프로필 일기 목록 클릭 이벤트
	$("#profile_diary_img_list").on("click", "li", function() {
		$("#diary_no").val($(this).attr("diary_no"));
		
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
			if(result.checkLike==0) {
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
			console.log(result.checkLike);
			if(result.checkLike==0) {
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
			checkDiaryLike();
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
			checkDiaryLike();
			cntDiaryLike();
		},
		error: function(request, status, error) {
			console.log(error);
		}
	});
}

// 팔로우 여부 //////////////////////////////////////////////////
function checkFolw() {
	var params = {
					"memberNo": $("#member_no").val(),
					"diaryNo": $("#diary_no").val()
				 };
	
	$.ajax({
		url: "checkFolwAjax",
		type: "post",
		dataType: "json",
		data: params,
		success: function(result) {
			if(result.checkFolw==0) {
				$("#folw_btn").text("팔로우");
			} else {
				$("#folw_btn").text("팔로잉");
			}
		},
		error: function(request, status, error) {
			console.log(error);
		}
	});
}

// 팔로우 버튼 클릭 이벤트 ///////////////////////////////////////////////////////

// 신고창 초기화
function resetAccuse() {
	$("#title").val("");
	$("#reason_code").val("");
	$("#accuse_con").val("");
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
	console.log("해시태그 목록 로드");
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

// 댓글창 로드