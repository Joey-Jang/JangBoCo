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
<script type="text/javascript" src="resources/script/jquery/jquery-1.12.4.min.js"></script>
<script type="text/javascript" src="resources/script/layout/default.js"></script>
<script type="text/javascript" src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=9a34fa20b8bdbafa1061701c69f892c1&libraries=services"></script>
<script type="text/javascript" src="resources/script/layout/addrsMapApi.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	reloadRecipeDtl()
});

function reloadRecipeDtl(){	
	var params = $("#recipe_dtl_form").serialize();
	
	$.ajax({
		url: "recipeDtlAjax", 
		type: "post", 
		dataType: "json", 
		data: params, 
		success : function(res) {			
			drawRecipeDtl(res.recipe);			
		},
		error: function(request, status, error) { 
			console.log(error);
		}
	});
}

function drawRecipeDtl(data){
	var html = "";		
	
	html += "<div class=\"recipe_info\">    ";
	html += "	<span>" + data.RECIPE_NAME + "</span>       ";
	html += "	<div><img src=\""+ data.ATT_FILE_MAIN +"\"></div>     ";
	html += "	<div>                     ";
	html += "		<span>"+ data.RECIPE_WAY2 +"</span>";	        		
	html += "		<span>"+ data.RECIPE_PAT2 +"</span>";	        		
	html += "		<span>"+ data.INFO_ENG +"</span>	  ";      		
	html += "		<span>"+ data.INFO_CAR +"</span>";	        		
	html += "		<span>"+ data.INFO_PRO +"</span>	  ";      		
	html += "		<span>"+ data.INFO_FAT +"</span>	  ";      		
	html += "		<span>"+ data.INFO_NA +"</span>	  ";      		
	html += "	</div>                    ";
	html += "	<div>"+ data.RECIPE_PARTS_DTLS +"</div>       ";
	html += "</div>                       ";
	html += "<div class=\"recipe_manual\">  ";
	html += "	<div>                     ";
	if(data.MANUAL_IMG1 != null && data.MANUAL_IMG1 != ''){
		html += "		<img src=\""+ data.MANUAL_IMG1 +"\">         ";		
	};
	if(data.MANUAL1 != null && data.MANUAL1 != ''){
		html += "		<span>"+ data.MANUAL1 +"</span>  ";		
	};
	if(data.MANUAL_IMG2 != null && data.MANUAL_IMG2 != ''){
		html += "		<img src=\""+ data.MANUAL_IMG2 +"\">         ";		
	};
	if(data.MANUAL2 != null && data.MANUAL2 != ''){
		html += "		<span>"+ data.MANUAL2 +"</span>  ";		
	};	
	if(data.MANUAL_IMG3 != null && data.MANUAL_IMG3 != ''){
		html += "		<img src=\""+ data.MANUAL_IMG3 +"\">         ";		
	};
	if(data.MANUAL3 != null && data.MANUAL3 != ''){
		html += "		<span>"+ data.MANUAL3 +"</span>  ";		
	};	
	if(data.MANUAL_IMG4 != null && data.MANUAL_IMG4 != ''){
		html += "		<img src=\""+ data.MANUAL_IMG4 +"\">         ";		
	};
	if(data.MANUAL4 != null && data.MANUAL4 != ''){
		html += "		<span>"+ data.MANUAL4 +"</span>  ";		
	};	
	if(data.MANUAL_IMG5 != null && data.MANUAL_IMG5 != ''){
		html += "		<img src=\""+ data.MANUAL_IMG5 +"\">         ";		
	};
	if(data.MANUAL5 != null && data.MANUAL5 != ''){
		html += "		<span>"+ data.MANUAL5 +"</span>  ";		
	};	
	if(data.MANUAL_IMG6 != null && data.MANUAL_IMG6 != ''){
		html += "		<img src=\""+ data.MANUAL_IMG6 +"\">         ";		
	};
	if(data.MANUAL6 != null && data.MANUAL6 != ''){
		html += "		<span>"+ data.MANUAL6 +"</span>  ";		
	};	
	if(data.MANUAL_IMG7 != null && data.MANUAL_IMG7 != ''){
		html += "		<img src=\""+ data.MANUAL_IMG7 +"\">         ";		
	};
	if(data.MANUAL7 != null && data.MANUAL7 != ''){
		html += "		<span>"+ data.MANUAL7 +"</span>  ";		
	};	
	if(data.MANUAL_IMG8 != null && data.MANUAL_IMG8 != ''){
		html += "		<img src=\""+ data.MANUAL_IMG8 +"\">         ";		
	};
	if(data.MANUAL8 != null && data.MANUAL8 != ''){
		html += "		<span>"+ data.MANUAL8 +"</span>  ";		
	};	
	if(data.MANUAL_IMG9 != null && data.MANUAL_IMG9 != ''){
		html += "		<img src=\""+ data.MANUAL_IMG9 +"\">         ";		
	};
	if(data.MANUAL9 != null && data.MANUAL9 != ''){
		html += "		<span>"+ data.MANUAL9 +"</span>  ";		
	};	
	if(data.MANUAL_IMG10 != null && data.MANUAL_IMG10 != ''){
		html += "		<img src=\""+ data.MANUAL_IMG10 +"\">         ";		
	};
	if(data.MANUAL10 != null && data.MANUAL10 != ''){
		html += "		<span>"+ data.MANUAL10 +"</span>  ";		
	};	
	if(data.MANUAL_IMG11 != null && data.MANUAL_IMG11 != ''){
		html += "		<img src=\""+ data.MANUAL_IMG11 +"\">         ";		
	};
	if(data.MANUAL11 != null && data.MANUAL11 != ''){
		html += "		<span>"+ data.MANUAL11 +"</span>  ";		
	};	
	if(data.MANUAL_IMG12 != null && data.MANUAL_IMG12 != ''){
		html += "		<img src=\""+ data.MANUAL_IMG12 +"\">         ";		
	};
	if(data.MANUAL12 != null && data.MANUAL12 != ''){
		html += "		<span>"+ data.MANUAL12 +"</span>  ";		
	};	
	if(data.MANUAL_IMG13 != null && data.MANUAL_IMG13 != ''){
		html += "		<img src=\""+ data.MANUAL_IMG13 +"\">         ";		
	};
	if(data.MANUAL13 != null && data.MANUAL13 != ''){
		html += "		<span>"+ data.MANUAL13 +"</span>  ";		
	};	
	if(data.MANUAL_IMG14 != null && data.MANUAL_IMG14 != ''){
		html += "		<img src=\""+ data.MANUAL_IMG14 +"\">         ";		
	};
	if(data.MANUAL14 != null && data.MANUAL14 != ''){
		html += "		<span>"+ data.MANUAL114 +"</span>  ";		
	};	
	if(data.MANUAL_IMG15 != null && data.MANUAL_IMG15 != ''){
		html += "		<img src=\""+ data.MANUAL_IMG15 +"\">         ";		
	};
	if(data.MANUAL15 != null && data.MANUAL15 != ''){
		html += "		<span>"+ data.MANUAL15 +"</span>  ";		
	};	
	if(data.MANUAL_IMG16 != null && data.MANUAL_IMG16 != ''){
		html += "		<img src=\""+ data.MANUAL_IMG16 +"\">         ";		
	};
	if(data.MANUAL16 != null && data.MANUAL16 != ''){
		html += "		<span>"+ data.MANUAL16 +"</span>  ";		
	};	
	if(data.MANUAL_IMG17 != null && data.MANUAL_IMG17 != ''){
		html += "		<img src=\""+ data.MANUAL_IMG17 +"\">         ";		
	};
	if(data.MANUAL17 != null && data.MANUAL17 != ''){
		html += "		<span>"+ data.MANUAL17 +"</span>  ";		
	};	
	if(data.MANUAL_IMG18 != null && data.MANUAL_IMG18 != ''){
		html += "		<img src=\""+ data.MANUAL_IMG18 +"\">         ";		
	};
	if(data.MANUAL18 != null && data.MANUAL18 != ''){
		html += "		<span>"+ data.MANUAL18 +"</span>  ";		
	};	
	if(data.MANUAL_IMG19 != null && data.MANUAL_IMG19 != ''){
		html += "		<img src=\""+ data.MANUAL_IMG19 +"\">         ";		
	};
	if(data.MANUAL19 != null && data.MANUAL19 != ''){
		html += "		<span>"+ data.MANUAL19 +"</span>  ";		
	};	
	if(data.MANUAL_IMG20 != null && data.MANUAL_IMG20 != ''){
		html += "		<img src=\""+ data.MANUAL_IMG20 +"\">         ";		
	};
	if(data.MANUAL20 != null && data.MANUAL20 != ''){
		html += "		<span>"+ data.MANUAL20 +"</span>  ";		
	};	
	
	html += "	</div>                    ";
	html += "</div>                       ";		
	
	$(".recipe_contnr").html(html);
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
            <form action="#" id="recipe_dtl_form" method="post">
            	<input type="hidden" id="page" name="page" value="${param.page}">
            	<input type="hidden" id="recipe_no" name="recipeNo" value="${param.recipeNo}">
            </form>
	        <div class="recipe_contnr">	        
       		        		     	
	        </div>
        </div>
    </div>
    <div class="bottom_contnr"></div>
</main>
</body>
</html>