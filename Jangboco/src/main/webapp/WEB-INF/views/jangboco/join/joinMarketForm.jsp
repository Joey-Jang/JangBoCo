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
<link rel="stylesheet" type="text/css" href="resources/css/join/join.css">
<script type="text/javascript" src="resources/script/jquery/jquery-1.12.4.min.js"></script>
<script type="text/javascript" src="resources/script/layout/default.js"></script>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script type="text/javascript">
// 이메일 인증번호
var emailNum;
// 이메일 존재하는지 확인하는 값
var emailFlag = false;
// 이메일 정규식 유효성 확인값
var emailValidate = false;
//이메일 정규식 사용
var eCheck=/^[_a-zA-Z0-9]+([-+.][_a-zA-Z0-9]+)*@([0-9a-zA-Z_-]+)(\.[0-9a-zA-Z_-]+){1,2}$/i;

// 기업명 등록을 위한 정보
var marketNo = "";
var marketName = "";
var marketAndBranch = "";
var branchName = "";

//사업자 등록 가능 여부
var RegnumResult = false;

$(document).ready(function(){
   
   
   
   $("#email_check_btn").on("click",function(){
      if(checkVal("#email")){
          alert("이메일을 입력해주세요");
          $("#email").focus();
       } else if(!emailValidate){
          alert("유효한 이메일을 입력해주세요");
          $("#email").focus();
       } else {
         var email = $("#email").val();
         $("#email_check_input").removeClass("hidden");
         
         $.ajax({
            type:"GET",
            url:"mailCheck?email="+email,
            success: function(data){
               emailNum = data;
            },
            error: function(error){
               console.log("error");
            }
         });
       }
   });
   
   $("#email_re_check_btn").on("click",function(){
      if($("#email_re_check").val()==emailNum){
         alert("인증번호가 일치합니다");
         emailFlag = true;
         $("#email").attr("disabled",true);
         $("#email_check_btn").attr("disabled",true);
         $("#email_re_check").attr("disabled",true);
         $("#email_re_check_btn").attr("disabled",true);
      } else {
         alert("인증번호가 틀렸습니다");
         emailFlag = false;
      }
   });
   
   $("#cancel_btn").on("click",function(){
      history.back();
   });
   
   $("#market_join_btn").on("click",function(){
      if(checkVal("#name")){
         alert("대표자 이름을 입력해주세요");
         $("#name".focus());
       } else if (checkVal("#email")){
          alert("이메일을 입력해주세요");
          $("#email").focus();
          email_re_check
       } else if (checkVal("#email_re_check")){
          alert("이메일 인증을 확인해주세요");
          $("#email_re_check").focus();
       } else if (checkVal("#pw")){
         alert("비밀번호를 입력해주세요");
         $("#pw").focus();
      } else if (checkVal("#pw_check")){
         alert("비밀번호 확인란을 입력해주세요");
         $("#pw_check").focus();
      } else if ($("#pw").val() != $("#pw_check").val()){
         alert("비밀번호 확인이 일치하지 않습니다");
      } else if (checkVal("#market_no")) {
    	 alert("기업명을 다시 검색해주세요");
      } else if (emailFlag==false){
         alert("인증번호를 확인해주세요");
      } else if (checkVal("#zipcd_other")){
         alert("우편번호를 입력해주세요");
         $("#zipcd_other").focus();
      } else if (checkVal("#addrs_other")){
         alert("주소를 입력해주세요");
         $("#addrs_other").focus();
      } else if (checkVal("#dtl_addrs")){
         alert("상세주소를 입력해주세요");
         $("#dtl_addrs").focus();
      } else if(checkVal("#regdate")){
    	 alert("사업자 등록일을 입력해주세요");
    	 $("#regdate").focus();
      } else if (!RegnumResult){
    	  alert("사업자 등록번호를 확인해주세요");
      } else if (checkVal("#phone_num")){
    	  alert("전화번호를 입력해주세요");
    	  $("#phone_num").focus();
      } else if (checkVal("#start_time")){
    	  alert("영업시작시간을 입력해주세요");
    	  $("#start_time").focus();
      } else if (checkVal("#end_time")){
    	  alert("영업마감시간을 입력해주세요");
    	  $("#end_time").focus();
      }else if ($("#agrnt_box").prop("checked") == false){
         alert("약관동의를 확인해주세요");
      } else {
         alert("가입완료!");
         $("#market_join_form").submit();
      } 
   });
   
   $("#zipcd_btn").on("click",function(){
       new daum.Postcode({
           oncomplete: function(data) {
               $("#zipcd_other").val(data['zonecode']);
               $("#addrs_other").val(data['address']);
               toDisabled("#addrs_other");
           }
       }).open();
   });
   
   toDisabled("#zipcd_other");
   toDisabled("#email_check_btn");
   
   $("#email").on('keyup',function(event){
      if(!eCheck.test($("#email").val())){
         emailValidate = false;
         $("#email_warn").text("유효한 이메일 주소를 입력해주세요");
         $("#email_warn").css("color","red");
      } else {
         emailValidate = true;
      }
      
      if(emailValidate == true){
         $.ajax({
            type:"POST",
            url: "validEmail",
            dataType:"json",
            data: {"email":$("#email").val()},
            success: function(res){
               if(res.result=="true"){
                  $("#email_warn").text("가입 가능한 이메일 주소입니다");
                  $("#email_warn").css("color","green");
                  toEnabled("#email_check_btn");
               } else {
                  $("#email_warn").text("이미 가입된 이메일입니다");
                  $("#email_warn").css("color","red");
                  toDisabled("#email_check_btn");
               }
            }, 
            error: function(error){
               console.log(error);
            }
         });
      }
      
   });
   
   
   
   $("#market_name_btn").on("click",function(){
      $("#market_modal").removeClass("hidden");
      modalInit();
      //1.지역구 주소 전부 받아오기(select option설정) ajax
      $.ajax({
         url: "getDisctAjax",
         type: "post",
         dataType: "json",
         success: function(res){
            getDisct(res.list);
         },
         error: function(error){
            console.log(error);
         }
      })
   });
   
   
   $("#market_list_search").on("click",function(){
      $("#branch_list_table").html("");
         
       
      //지역구, 검색명 검색해오기 ajax
      $.ajax({
         url:"searchMarketAjax",
         type: "post",
         dataType: "json",
         data: {
            "disct": $("#disct_select option:selected").val(),
            "marketName": $("#market_name").val()
         },
         success: function(res){
            getMarkets(res.list);
            
         }, 
         error: function(error){
            console.log(error);
         }
         
      });
   });
   
   $("#market_input_btn").on("click",function(){
      //해당 지점있는지 한번더 확인하고 닫기 ajax
      if(marketNo==""){
    	  alert("마켓을 선택해주세요");
      } else {
	    var result = false;
	    if(checkVal("#market_input")==true){
	       result = confirm("지점입력없이 등록하시겠습니까?");
	       if(result==true){
	          //지점없이 등록
	          checkAddMarket();
	       }
	    } else {
	       //내용있을때 그냥 등록
	    	checkAddMarket();
	    }      
      }
   });
   
   //마켓명 누르면 해당 지점명 가져오기
   $("#market_list_table").on("click","tr",function(){
      //해당 지점명 가져오기 ajax
      $("#market_list_table").find('tr').css('background','');
      $(this).css('background-color','#BCE55C');
      marketNo = $(this).attr("market_no");
      marketName = $(this).children('td').text();

      alert($(this).attr("market_no"));
      $.ajax({
         url:"searchBranchAjax",
         type: "post",
         dataType: "json",
         data: {
            "marketNo": $(this).attr("market_no")
         },
         success: function(res){
            getBranches(res.list);
         }, 
         error: function(error){
            console.log(error);
         }
         
      });
      
      
   });

   
   //지점명은 클릭해도 아무것도 생기지 않음
   
   $("#close_market_btn").on("click",function(){
	   marketNo = "";
	   $("#market_modal").addClass("hidden");
      
   });
   
   
   toDisabled("#market_member_name");

   
   $("#regnum_check_btn").on("click",function(){
      //이미 존재하는 번호인지 
      //정말 사업장 등록번호에 존재하는 번호인지
      var result = checkRegnum($("#regnum").val(), $("#regdate").val(), $("#name").val());
      if(result == "01"){
         $("#regnum_warn").text("정상적인 사업자 등록번호입니다");
         RegnumResult = true;
      } else {
    	  RegnumResult = false;
          $("#regnum_warn").text("비정상적인 사업자 등록번호입니다");
          $("#regnum_warn").css("color","red");
      }
      
      //사업자 등록번호가 등록되어있는지 확인
      if(RegnumResult==true){
    	  $.ajax({
    		  url:"checkRegnum",
    		  type: "post",
    		  dataType: "json",
    		  data: {
    			  "regnum":$("#regnum").val()
    		  },
    		  success: function(res){
    			  console.log(res);
    			  if(res.result==0){
        			  RegnumResult = true;
        	          $("#regnum_warn").text("가입가능한 사업자 등록번호입니다");
        	          $("#regnum_warn").css("color","green");
        	          toDisabled("#name");
        	          toDisabled("#regdate");
        	          toDisabled("#regnum");
        	          toDisabled("#regnum_check_btn");
    			  } else {
        			  RegnumResult = false;
        	          $("#regnum_warn").text("이미 가입된 사업자 등록번호입니다");
        	          $("#regnum_warn").css("color","red");
    			  }
    		  },
    		  error: function(error){
    			  RegnumResult = false;
    			  console.log(error);
    		  }
    	  })
      }
      
   });
});

function modalInit(){
   $("#market_list_table").html("");
   $("#branch_list_table").html("");
   $("#market_name").val("");
   $("#market_input").val("");
}

function getDisct(list){
   var html = "<option value=\"0\"> 선택</option>";
   for(var data of list){
      html += "<option value=\""+data.DISCT_NO+"\">"+data.DISCT_NAME+"</option>"
   } 
   $("#disct_select").html(html);
}

function getMarkets(list){
   var html = "";
   for(var data of list) {
      html += "<tr market_no=\""+data.MARKET_NO+"\">";
      html += "<td>";
      html += data.MARKET_NAME;
       html += "</td>";
       html += "</tr>";
   }
   
   $("#market_list_table").html(html);
   
}

function getBranches(list){
   var html = "";
   for(var data of list) {
      html += "<tr><td>";
      html += data.BRANCH_NAME;
       html += "</td></tr>";
   }
   
   $("#branch_list_table").html(html);
   
}


function checkVal(sel) {
   if($.trim($(sel).val()) == "") {
      return true;
   } else {
      return false;
   }
}

function toEnabled(sel){
   $(sel).attr("disabled",false);
}

function emailEnabled(){
   toEnabled("#email");
   toEnabled("#email_check_btn");
   toEnabled("#zipcd_other");
   toEnabled("#addrs_other");
   toEnabled("#name");
   toEnabled("#regnum");
}

function toDisabled(sel){
   $(sel).attr("disabled",true);
}

function checkAddMarket(){
 /* ajax로 있는 기업인지 확인하기 
   	input 내용이 없을시에는 지점이 없는 경우
   	등록된 마켓이 있는지 확인한다 (첫번째 컬럼은 널인값, 두번째 값은 널이 아닌값) 
 	이미 등록된 지점인지(널이 1개이상) or 지점이 있는 경우(널이 아닌값이 존재)인지 리턴
 	둘다 널인경우 그냥 등록가능
	브랜치지점이 있는경우에는 똑같은 지점이 있는지만 다시 확인해주기
	SELECT COUNT1,COUNT2 FROM (SELECT COUNT(*) AS COUNT1 FROM MARKET_MEMBER
			WHERE BRANCH_NAME IS NULL AND MARKET_NO = '100002') A,
			(SELECT COUNT(*) AS COUNT2 FROM MARKET_MEMBER
			    WHERE BRANCH_NAME IS NOT NULL AND MARKET_NO = '100002') B
	
 */	

 	$.ajax({
 		url:"checkAddMarket",
  		data: {
 			"market_no":marketNo		
 		}, 
 		type: "post",
 		success: function(res){
 			var count1 = res.result['COUNT1'];
 			var count2 = res.result['COUNT2'];

 				if(count1==0&&count2==0){
 					alert("등록합니다");
 					addFormBranch();
 				} else if (count1>0){
 					alert("이미 등록된 마켓입니다");
 				}
 				if(count2>0){
 					//지점이 여러개 있는경우 무조건 지점을 입력받아야함 
 					if($("#market_input").val()!=""){
	 					var result = checkBranchName(marketNo, $("#market_input").val());
	 					if(result){
	 						alert("새로 등록합니다");
	 						addFormBranch();
	 					} else {
	 						alert("이미 있는 지점입니다");
	 					}
 					} else {
 						alert("지점 입력이 필수인 마켓입니다");
 					}
 				}
 		},
 		error: function(error){
 			console.log(error);
 		}
 	});

}

function checkBranchName(marketNo, branchName){
	var result = false;
	$.ajax({
 		url:"checkBranchName",
  		data: {
 			"market_no":marketNo,
 			"branch_name":branchName
 		}, 
 		async: false,
 		type: "post",
 		success: function(res){
 			if(res.result == 0){
 				//지점없음
 				result = true;
 			} else {
 				result = false;
 			}
 		},
 		error: function(error){
 			console.log(error);
 		}
 	});
	return result;
	
}

function addFormBranch(){
	branchName = $("#market_input").val();
	   $("#market_no").val(marketNo);
	   $("#branch_name").val(branchName);
	   $("#market_member_name").val(marketName+" "+branchName);
	   $("#market_modal").addClass("hidden");
}

function checkRegnum(b_no, start_dt, p_nm){
   var result = "";
   var data = {
           "businesses": [
                {
                  "b_no": b_no,
                  "start_dt": start_dt,
                  "p_nm": p_nm
                }
              ]
            };
   
   var serviceKey = "6HQWWR6iibX4NvJpYaP%2BP%2Blivy9AiBISgqmHA%2FxT4vsJKPwxr%2BRIMG%2BNFDhz3ZWkSJHoyDp3cTjzF2dfuXG84w%3D%3D";

   $.ajax({
      type:"POST",
      url:"https://api.odcloud.kr/api/nts-businessman/v1/validate?serviceKey="+serviceKey,
      contentType: "application/json; charset=utf-8",
      data:JSON.stringify(data),
      async: false,
      success: function(data){
         result = data['data'][0]['valid'];
      },
      error: function(error){
         result = "error";
      }
   });
   return result;
}

</script> 
</head>
<body>
<c:import url="/layoutTopLeft"></c:import>
<main>
    <div class="con_contnr">
       <div class="market_modal hidden" id="market_modal">
          <div class="market_contnr">
             <div class="market_contnr_top">
                <div class="market_contnr_top_header">
                   <input type="button" id="close_market_btn" class="close_market_btn" value="X"/>
                </div>
                <div class="market_search">
                   <select id="disct_select">
                      <option>선택</option>
                   </select>
                   <input type="text" id="market_name"/>
                   <input type="button" id="market_list_search" value="검색"/>
                </div>
                  <div class="market_info">마켓명</div>
                <div class="market_list">
                   <table id="market_list_table">
                                        
                   </table>
                </div>
             </div>
             <div class="market_contnr_bottom">
                  <div class="market_branch_info">지점명</div>
                  <span class="branch_warn">(목록에 없는 지점으로 등록해주세요)</span>
               <div class="market_branch_list">             
                   <table id="branch_list_table">                                                                  
                   </table>
                </div>
             </div>
             <div class="market_input_contnr">
                <input type="text" id="market_input" class="market_input"/>
                <input type="button" id="market_input_btn" value="등록"/>
             </div>
          </div>
       </div>
        <div class="join_con">
           <div class="join_form_header">
              회원가입
           </div>
           <div class="join_form_body">
              <div class="join_form">
                 <form action="joinMarketMember" id="market_join_form" method="post" onsubmit="emailEnabled()">
                      <div class="form_input">
                         <div class="form_input_text">
                            대표자 이름
                         </div>
                         <div class="form_input_val">
                            <input id="name" name="name"/>
                         </div>                    
                      </div>
                      <div class="form_input" >
                         <div class="form_input_text">
                            <span>기업명</span>
                         </div>
                         
                         <div class="market_name_input">
                            <div class="form_input_val">
                               <input type="hidden" id="market_no" name="market_no"/>
                               <input type="hidden" id="branch_name" name="branch_name"/>
                               <input type="text" id="market_member_name" name="market_member_name"/>
                            </div>
                            <div class="market_name_btn">
                               <input type="button" id="market_name_btn" value="찾기"/>
                            </div>
                         </div>                    
                      </div>
                      <div class="form_input" >
                         <div class="form_input_text">
                            <span>이메일</span>
                            <span id="email_warn"></span>
                         </div>
                         
                         <div class="email_input">
                            <div class="form_input_val">
                               <input type="email" id="email" name="email"/>
                            </div>
                            <div class="check_btn">
                               <input type="button" id="email_check_btn" value="전송"/>
                            </div>
                         </div>                    
                      </div>
                      <div class="form_input hidden" id="email_check_input">
                         <div class="form_input_text">
                            이메일 인증
                         </div>
                         <div class="email_input">
                            <div class="form_input_val">
                               <input id="email_re_check" name="email_re_check" placeholder="인증번호를 입력하세요"/>
                            </div>
                            <div class="check_btn">
                                  <input type="button" id="email_re_check_btn" value="확인"/>
                            </div>                 
                         </div>   
                      </div>
                      <div class="form_input">
                         <div class="form_input_text">
                            비밀번호
                         </div>
                         <div class="form_input_val">
                            <input type="password" id="pw" name="pw"/>
                         </div>                    
                      </div>
                      <div class="form_input">
                         <div class="form_input_text">
                            비밀번호 확인
                         </div>
                         <div class="form_input_val">
                            <input type="password" id="pw_check" name="pw_check"/>
                         </div>                    
                      </div>
                      <div class="form_input" >
                         <div class="form_input_text">
                            <span>사업자 등록일</span>
                         </div>
                         
                         <div class="regdate_input">
                            <div class="form_input_val">
                               <input id="regdate" name="regdate" placeholder="예) 20180203"/>
                            </div>
                         </div>                    
                      </div>
                      <div class="form_input" >
                         <div class="form_input_text">
                            <span>사업자 등록번호</span>
                            <span id="regnum_warn"></span>
                         </div>
                         
                         <div class="regnum_input">
                            <div class="form_input_val">
                               <input id="regnum" name="regnum" placeholder="예)0123456789"/>
                            </div>
                            <div class="regnum_check">
                               <input type="button" id="regnum_check_btn" value="확인"/>
                            </div>
                         </div>                    
                      </div>
                      <div class="form_input">
                         <div class="form_input_text">
                            사업장주소 우편번호
                         </div>
                         <div class="form_zipcd">
                            <div class="form_input_val">
                               <input id="zipcd_other" name="zipcd"/>
                            </div>                    
                            <div class="find_addrs">
                               <input class="zipcd_btn" id="zipcd_btn" type="button" value="주소확인">
                            </div>       
                         </div>
                      </div>
                      
                       <div class="form_input">
                         <div class="form_input_text">
                            사업장주소
                         </div>
                         <div class="form_input_val">
                            <input id="addrs_other" name="addrs"/>
                         </div>                    
                      </div>
                       <div class="form_input">
                         <div class="form_input_text">
                            상세주소
                         </div>
                         <div class="form_input_val">
                            <input id="dtl_addrs" name="dtl_addrs"/>
                         </div>
                      </div>
                       <div class="form_input">
                         <div class="form_input_text">
                            전화번호
                         </div>
                         <div class="form_input_val">
                            <input id="phone_num" name="phone_num"/>
                         </div>
                      </div>                      
                      
                      <div class="form_input">
                         <div class="form_input_text">
                            영업시작시간
                         </div>
                         <div class="form_input_val">
                            <input type="time" id="start_time" name="start_time"/>
                         </div>
                      </div>
                      
                      <div class="form_input">
                         <div class="form_input_text">
                            영업종료시간
                         </div>
                         <div class="form_input_val">
                            <input type="time" id="end_time" name="end_time"/>
                         </div>
                      </div>
                      
                                            
                      <div class="form_input agrnt_input">
                       <input type="checkbox" id="agrnt_box"/>
                         <div class="">
                            약관동의
                         </div>                 
                      </div>
                 </form>
                 <div class="join_btn">
                    <input type="button" value="가입" id="market_join_btn" >
                    <input type="button" value="취소" id="cancel_btn">
                 </div>
              </div>
           </div>
        </div>
    </div>
    <div class="bottom_contnr"></div>
</main>
</body>
</html>