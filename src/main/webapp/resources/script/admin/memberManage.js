$(document).ready(function() {
	loadList();
	
	// 엔터키 차단 / ajax 동작
	$("#action_form").on("keypress", "input", function(event) {
		if(event.keyCode==13) {
			$("#search_btn").click();
			return false;
		}
	});
	
	// 검색
	$("#search_btn").on("click", function() {
		$("#page").val("1");
		
		$("#old_txt").val($("#search_txt").val());
		
		loadList();
	});
	
	// 페이징
	$("#paging_contnr").on("click", "span", function() {
		$("#page").val($(this).attr("page"));
		
		$("#search_txt").val($("#old_txt").val());
		
		loadList();
	});
});



function loadList() {
	var params = $("#action_form").serialize();
	
	$.ajax({
		url: "getMemberListAjax",
		type: "post",
		data: params,
		dataType: "json",
		success: function(result) {
			drawList(result.list);
			drawPaging(result.pb);
		},
		error: function(request, status, error) {
			console.log(error);
		}
	});
}

function drawList(list) {
	var html = "";
	
	for(var data of list) {
		html += "<tr no=\"" + data.MEMBER_NO + "\">";
		html += "	<td>" + data.MEMBER_NO + "</td>";
		html += "	<td>" + data.EMAIL + "</td>";
		html += "	<td>" + data.NAME + "</td>";
		html += "	<td>" + data.NICNM + "</td>";
		html += "	<td>" + data.ZIPCD + "</td>";
		html += "	<td>" + data.ADDRS + "</td>";
		if(data.DTL_ADDRS!=undefined) {
			html += "<td>" + data.DTL_ADDRS + "</td>";
		} else {
			html += "<td></td>"
		}
		html += "	<td>" + data.REGST_DATE + "</td>";
		if(data.WITWL_DATE!=undefined) {
			html += "<td>" + data.WITWL_DATE + "</td>";
		} else {
			html += "<td></td>";
		}
		html += "</tr>";
	}
	
	$("#member_list > tbody").html(html);
}

function drawPaging(pb) {
	var html = "";
	
	html += "<span page=\"1\">처음</span> ";
	if($("#page").val()=="1") {
		html += "<span page=\"1\">이전</span>                                  ";
	} else {
		html += "<span page=\"" + ($("#page").val() * 1 - 1) + "\">이전</span> ";
	}
	for(var i=pb.startPcount; i<=pb.endPcount; i++) {
		if($("#page").val()==i) {
			html += "<span page=\"" + i + "\"><b>" + i + "</b></span> ";
		} else {
			html += "<span page=\"" + i + "\">" + i + "</span>        ";
		}
	}
	if($("#page").val()==pb.maxPcount) {
		html += "<span page=\"" + pb.maxPcount + "\">다음</span>               ";
	} else {
		html += "<span page=\"" + ($("#page").val() * 1 + 1) + "\">다음</span> ";
	}
	html += "<span page=\"" + pb.maxPcount + "\">마지막</span> ";
	
	$("#paging_contnr").html(html);
}