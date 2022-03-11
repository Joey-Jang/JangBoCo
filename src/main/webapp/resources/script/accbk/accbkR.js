$(document).ready(function(){
	if("${param.search_gbn}" != "") {
		$("#search_gbn").val("${param.search_gbn}");
	}
	getList();
	
	//목록 sort
	$(function(){
		$("#accbk_r_tbl").tablesorter({ sortList: [[0,0], [1,0]] });
	});
	
	//지출 내역 추가 
	$("#write_btn").on("click", function(){
		$("#action_form").attr("action", "accbkC");
		$("#action_form").submit();
	});
	
	//검색
	$("#search_btn").on("click", function(){
		$("#page").val("1");
		getList();
	});
	
	//enter로 검색해도 비동기화 되게 
	$("#search_text").on("keypress", function(event){
		if(event.keyCode == 13) {
			$("#search_btn").click();
			return false;
		}
	});
	
	//삭제_체크박스_모두_체크
	 $( '.chkbx_all' ).click( function() {
          $( '.chkbx_pernl' ).prop( 'checked', this.checked );
        } );
	
	//삭제_버튼_누르면_체크박스,선택삭제_show
	$("#del_btn").on("click", function(){
		$('[name="del_chkbx"]').show();
		$("#select_del_btn").show();
		$("#del_cancel_btn").show();
		$("#del_btn").hide();
		
	}); 
	//취소_버튼_누르면_삭제버튼과_전부반대로
	$("#del_cancel_btn").on("click",function(){
		$('[name="del_chkbx"]').hide();
		$("#select_del_btn").hide();
		$("#del_cancel_btn").hide();
		$("#del_btn").show();
	});
	
	
	
	//삭제
	$("#select_del_btn").on("click", function(){
		var chkbxArr = new Array();
		//console.log($('input[name="del_chkbx"]:checked'));
		$('input[name="del_chkbx"]:checked').each(function(){
			//chkbxArr.push($('input[name="del_chkbx"]:checked').val());
			chkbxArr.push(this.value);
		});
		//console.log(chkbxArr);
		var chkbxCnt = chkbxArr.length;
		
		if (chkbxCnt == 0) {
			alert("삭제할 지출 내역을 선택해주세요");
		} else {
			
		 	//$.ajaxSettings.traditional = true; 
			$.ajax({
				url : "accbkDAjax",
				type : "post",
				dataType : "json",
				data : {"del_chkbx" : JSON.stringify(chkbxArr)},
				success : function(result){
					if (result.msg=="success") {
						alert("삭제 성공");
						getList();
						$('[name="del_chkbx"]').hide();
						$("#select_del_btn").hide();
						$("#del_cancel_btn").hide();
						$("#del_btn").show();
					} else if(result.msg=="failed") {
						alert("삭제 실패");
					} else{
						alert("삭제 중 문제 발생");
					}
				},
				error : function(request, status, error){
					console.log(error);
				}
				
			}); //ajax 끝
		}
		
	});
	
	$("#paging_wrap").on("click","span", function(){
		$("#page").val($(this).attr("page"));
		
		getList();
	});	
	
	
	
		
});// document.ready 끝

//데이터 취득
function getList(){
	var params = $("#action_form").serialize();
									// action_form의 data를 문자열로 가져 옴 
	
	$.ajax({
		url :"accbkRAjax",
		type :"post",
		dataType :"json",
		data : params,
		success : function(result){
			drawList(result.list);
			drawPaging(result.pb);
		},
		error : function(request,status,error){
			console.log(error);
		}
	}); //ajax 끝

}; //function getList 끝

//수정
$("#").on("click",function(){
	var currentRow = $(this).closest('tr');
	console.log(currentRow);
	var updateBtn = $(this);
	 
	var tr = updateBtn.parent().parent();
	var td = tr.children();
	
	console.log(updateBtn);
	console.log(tr.text());
	
	
	$(".update_btn").attr("action","accbkU");
	
});


// 수정
function updateList(pa){
	$("#update_no").val(pa);
	$("#move_update").attr("action", "accbkU");
	$("#move_update").submit();
	
	
}


function drawList(list){
	 var html = "";
	 
	 for(var data of list){
		 html+=	"<tr id=\""+data.ACCBK_NO+"\">  ";
		 html+=	"<td><input type=\"checkbox\" name=\"del_chkbx\"class=\"chkbx_pernl\" value=\""+data.ACCBK_NO+"\"></td> ";
		 html+=	"<td>"+data.MARKET_NAME +"</td> ";
		 html+=	"<td>"+data.ITEMS_NAME +"</td> ";
		 html+=	"<td>"+data.BUY_QNT +"</td> ";
		 html+=	"<td>"+data.COST +"</td> ";
		 html+=	"<td>"+data.NOTE +"</td> ";
		 html+=	"<td>"+data.BUY_DATE +"</td> ";
		 html+=	"<td id=\""+data.ACCBK_NO+"\"><input type=\"button\" class=\"update_btn\" id=\""+data.ACCBK_NO+"\" onclick=\"updateList("+data.ACCBK_NO+")\" value=\"수정\" ></td> ";
		 /*onclick 추가 function param은 tr:id  onclick =\""updateList(""+data.ACCBK_NO+"\")"  */
		 html+= "</tr> ";
	 }
		 $("tbody").html(html);
}

function drawPaging(pb){
	var html ="";
	
	html += "<div class=\"paging_btn\" id=\"first_btn\">    "
	html += "	<span page=\"1\">처음</span>    "
	html += "</div>                  "
	html += "<div class=\"paging_btn\">                   "
	if($("#page").val()<=10){		
		html += "	<span page=\"1\">이전</span>    "
	} else {
		html += "	<span page=\"" +(pb.startPcount-1) + "\">이전</span>    "		
	}	
	html += "</div>                  "
	for(var i=pb.startPcount; i<=pb.endPcount; i++){		
		if($("#page").val()==i){
			html += "<div class=\"paging_btn\">                   "
			html += "	<span page=\""+ i + "\"><b>"+i+"</b></span>       "
			html += "</div>                  "			
		} else {
			html += "<div class=\"paging_btn\">                   "
			html += "	<span page=\""+ i + "\">"+i+"</span>       "
			html += "</div>                  "						
		}
	}
	
	if(pb.endPcount== pb.maxPcount){		
		html += "<div class=\"paging_btn\">                   "
		html += "	<span page=\""+pb.maxPcount +"\">다음</span>    "
		html += "</div>                  "
	} else {
		html += "<div class=\"paging_btn\">                   "
		html += "	<span page=\""+(pb.endPcount+1) +"\">다음</span>    "
		html += "</div>                  "		
	}
	html += "<div class=\"paging_btn\" id=\"last_btn\">     "
	html += "	<span page=\""+ pb.maxPcount +"\">마지막</span>  "
	html += "</div>                  "
	
	$(".paging_wrap").html(html);
}