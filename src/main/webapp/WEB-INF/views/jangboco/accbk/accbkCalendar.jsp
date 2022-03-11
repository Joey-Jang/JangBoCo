<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="preconnect" href="https://fonts.gstatic.com">
<link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100;300;400;500;700;900&display=swap">
<link rel="stylesheet" type="text/css" href="resources/css/layout/default.css">
<link rel="stylesheet" href="resources/css/accbk/accbkCalender.css" type="text/css">
<link rel="stylesheet" href="resources/fullcalender/main.css" type="text/css">
<script type="text/javascript" src="resources/script/jquery/jquery-1.12.4.min.js"></script>
<script type="text/javascript" src="resources/script/layout/default.js"></script>
<script type="text/javascript"	src="resources/fullcalender/main.js"></script>
<script type="text/javascript"	src="resources/fullcalender/locales-all.min.js"></script>
<script type="text/javascript" src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=9a34fa20b8bdbafa1061701c69f892c1&libraries=services"></script>
<script type="text/javascript" src="resources/script/layout/addrsMapApi.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	
	
	
  calendarMaker($("#calendar_form"), new Date());
  loadSum();
  
  $("#write_btn").on("click", function(){
		$("#action_form").attr("action", "accbkC");
		$("#action_form").submit();
	});
  $("#move_dtl_btn").on("click", function(){
		$("#action_form").attr("action", "accbkDtl");
		$("#action_form").submit();
	});
});

var nowDate = new Date();

function calendarMaker(target, date) {
    if (date == null || date == undefined) {
        date = new Date();
    }
    nowDate = date;
    if ($(target).length > 0) {
        var year = nowDate.getFullYear();
        var month = nowDate.getMonth() + 1;
        $(target).empty().append(assembly(year, month));
    } else {
        console.error("오류 발생");
        return;
    }

	var thisMonth = new Date(nowDate.getFullYear(), nowDate.getMonth(), 1);
    var thisLastDay = new Date(nowDate.getFullYear(), nowDate.getMonth() + 1, 0);


    var tag = "<tr>";
    var cnt = 0;
    //빈 공백 만들어주기
    for (i = 0; i < thisMonth.getDay(); i++) {
        tag += "<td></td>";
        cnt++;
    }

    //날짜 채우기
    for (i = 1; i <= thisLastDay.getDate(); i++) {
        if (cnt % 7 == 0) { tag += "<tr>"; }
        if(i < 10) {
	        tag += "<td no=\"" + i + "\">" + i + "<br><span id=\"" + "0" + i + "\"></span></td>";
        } else {
	        tag += "<td no=\"" + i + "\">" + i + "<br><span id=\"" + i + "\"></span></td>";
        }
        cnt++;
        if (cnt % 7 == 0) {
            tag += "</tr>";
        }
    }
    $(target).find("#custom_set_date").append(tag);
    calMoveEvtFn();
	
    

	function assembly(year, month) {
	    var calendar_html_code =
	        "<table class='custom_calendar_table'>" +
	        "<colgroup>" +
	        "<col style='width:81px'/>" +
	        "<col style='width:81px'/>" +
	        "<col style='width:81px'/>" +
	        "<col style='width:81px'/>" +
	        "<col style='width:81px'/>" +
	        "<col style='width:81px'/>" +
	        "<col style='width:81px'/>" +
	        "</colgroup>" +
	        "<thead class='cal_date'>" +
	        "<th><button type='button' class='prev'><</button></th>" +
	        "<th colspan='5'><p><span>" + year + "</span>년 <span>" + month + "</span>월</p></th>" +
	        "<th><button type='button' class='next'>></button></th>" +
	        "</thead>" +
	        "<thead  class='cal_week'>" +
	        "<th>일</th><th>월</th><th>화</th><th>수</th><th>목</th><th>금</th><th>토</th>" +
	        "</thead>" +
	        "<tbody id='custom_set_date'>" +
	        "</tbody>" +
	        "</table>";
	    return calendar_html_code;
	}
	
	function calMoveEvtFn() {
	    //전달 클릭
	    $(".custom_calendar_table").on("click", ".prev", function () {
	        nowDate = new Date(nowDate.getFullYear(), nowDate.getMonth() - 1, nowDate.getDate());
	        calendarMaker($(target), nowDate);
	    });
	    //다음날 클릭
	    $(".custom_calendar_table").on("click", ".next", function () {
	        nowDate = new Date(nowDate.getFullYear(), nowDate.getMonth() + 1, nowDate.getDate());
	        calendarMaker($(target), nowDate);
	    });
	    //일자 선택 클릭
	    $(".custom_calendar_table").on("click", "td", function () {
	        $(".custom_calendar_table .select_day").removeClass("select_day");
	        $(this).removeClass("select_day").addClass("select_day");
	    });
	}
}

function loadSum() {
	var today = new Date();
	var getMth = today.getMonth() +1;
	var getYear = today.getFullYear().toString();
	var mthStr = getMth.toString();
	
	var getToday = getYear+'-'+mthStr;
	  var params = {"memberNo": $("#member_no").val()}
	  
	  $.ajax({
		 	url: "getCalendarListAjax",
		 	type: "post",
		 	data: {"memberNo": $("#member_no").val(),
		 			"mthNy" : getToday},
		 	dataType: "json",
		 	success: function(result) {
		 		console.log(result.list.length);
		 		console.log(result.list);
		 		for(var i=0; i<result.list.length; i++) {
		 			console.log(result.list[i].SUM);
		 			$("#custom_set_date td[no=" + (i+1) + "]").children("span").text(result.list[i].SUM);
		 		}
		 	},
		 	error: function(request, status, error) {
		 		console.log(error);
		 	}
	  });
}

</script>
</head>

<body>
<c:import url="/layoutTopLeft"></c:import>
<main>
	 <form action="#" id="go_form" method="post">
         
      <input type="hidden" id="home_flag" name="home_flag" value="${homeFlag}">
      <input type="hidden" id="menu_idx" name="menu_idx" value="${menuIdx}">
      <input type="hidden" id="sub_menu_idx" name="sub_menu_idx" value="${subMenuIdx}">
   </form>
   <div class="con_contnr">
        <div class="con">
        <form action="#" id="action_form" method="post">
        	<input type="hidden" id="member_no" name="member_no" value="${sMNo}">
        </form>
        <input type="button" id="move_dtl_btn" class="accbk_cal_btn" value="자세히">
        <input type="button" id="write_btn" class="accbk_cal_btn" value="글쓰기">
         <div id="calendar_form"></div>
        </div>
	</div>
	 <div class="bottom_contnr"></div>
</main>
</body>
</html>