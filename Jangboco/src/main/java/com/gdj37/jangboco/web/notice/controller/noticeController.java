package com.gdj37.jangboco.web.notice.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.gdj37.jangboco.common.bean.PagingBean;
import com.gdj37.jangboco.common.service.IPagingService;
import com.gdj37.jangboco.web.notice.service.noticeIService;

@Controller
public class noticeController {

	@Autowired
	noticeIService noticeiService;
	
	@Autowired
	IPagingService iPagingService;
	
	//기본 페이지를 띄워주기 위한 주소 mapping
	@RequestMapping(value = "/noticeR")
	public ModelAndView accbkR(@RequestParam HashMap<String, String> params,
								ModelAndView mav) {
		
		int homeFlag = 0;
		int menuIdx = 3;
		int subMenuIdx = 0;
		mav.addObject("homeFlag", homeFlag);
		mav.addObject("menuIdx", menuIdx);
		mav.addObject("subMenuIdx", subMenuIdx);
		
		
		String page ="1";
		
		if(params.get("page")!=null) {
			page = params.get("page");	
		}
		
		mav.addObject("page",page);
		
		mav.setViewName("jangboco/notice/noticeR");
		
		return mav;
	}
	
	@RequestMapping(value = "/noticePernlListAjax", method = RequestMethod.POST,
					produces = "text/json;charset=UTF-8")
	@ResponseBody
	public String noticePernlListAjax(@RequestParam HashMap<String, String>params)throws Throwable{
		
		ObjectMapper mapper = new ObjectMapper(); 
		
		Map<String, Object> modelMap = new HashMap<String, Object>(); //데이터 담을 map
		
		try {
			//페이지 취득 
			int page = Integer.parseInt(params.get("page"));
			//개수 취득
			int cnt = noticeiService.getNoticeCnt(params);
			
			//페이징 정보 취득 
			PagingBean pb = iPagingService.getPagingBean(page,cnt);
			
			//데이터 시작, 종료값 할당 
			params.put("startCnt", Integer.toString(pb.getStartCount()));
			params.put("endCnt", Integer.toString(pb.getEndCount()));
			
			//list 조회
			
			List<HashMap<String, String>> list = noticeiService.getNoticeList(params);
			List<HashMap<String, String>> bestList = noticeiService.getNoticeBestList(params);
			modelMap.put("list", list);
			modelMap.put("bestList", bestList);
			modelMap.put("pb", pb);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return mapper.writeValueAsString(modelMap);
	}
	
	// 공지사항 상세보기
	@RequestMapping(value="/noticeDtl")
	public ModelAndView noticeDtl( HttpServletRequest request, HttpServletResponse response,
									 @RequestParam HashMap<String, String> params,
									 ModelAndView mav) throws Throwable {
		String noticeNo = params.get("noticeNo");
		if(noticeNo !=null) {			
			// 조회수 중복 방지를 위한 쿠키
			
			Cookie comprCookie = null; // 비교를 위한 쿠키 선언
			
			Cookie[] cookies = request.getCookies(); // 클라이언트의 쿠키를 가져옴.
			
			if(cookies != null) { 
				for(Cookie cookie : cookies) { 
					// for문으로 가져온 쿠키들의 이름을 비교
					// 클라이언트의 쿠키 중 해당 게시글을 읽었다면
					// 비교쿠키에 해당 쿠키값을 넣어준다.
					if(cookie.getName().equals("noticeView"+noticeNo)) {						
						comprCookie = cookie;
					}
				}
			}
			
			if(comprCookie ==null) {
				// 비교할 쿠키가 널이라면 해당 게시글을 읽은 이력이 없기 때문에
				// 새로운 쿠키를 noticeView + noticeNo 형식의 이름과, [ 행사글번호 ]를 저장. 
				Cookie newCookie = new Cookie("noticeView"+noticeNo,"["+ noticeNo +"]");
				
				newCookie.setMaxAge(60*60*1);
				
				// 새로 생성한 쿠키를 클라이언트의 브라우저저장소에 추가
				response.addCookie(newCookie);
				
				// 비교할 쿠키가 널이었기 때문에 조회수를 올려준다.
				int result = noticeiService.updateNoticeHit(params);				
			}
			
			HashMap<String, String> data = noticeiService.getNoticeDtl(params);
			
			mav.addObject("data",data);
			
			mav.setViewName("jangboco/notice/noticeDtl");				
		} else {
			mav.setViewName("redirect:/noticeR");
		}
		
		return mav;
	}
	
	@RequestMapping(value = "/noticeC")
	  public ModelAndView noticeC(ModelAndView mav) {
		 mav.setViewName("jangboco/notice/noticeC");
	  
		  return mav; 
	  }
	
	@RequestMapping(value = "/noticeU")
	  public ModelAndView noticeU(@RequestParam HashMap<String, String>params,
			  					ModelAndView mav) throws Throwable {
		
		HashMap<String, String> data = noticeiService.getNoticeDtl(params);
		
		mav.addObject("data", data);
		
		mav.setViewName("jangboco/notice/noticeU");
	  
		  return mav; 
	  }
	
	 @RequestMapping(value = "/noticeCUDAjax", method = RequestMethod.POST,
	 		 produces = "text/json;charset=UTF-8")
	 @ResponseBody 
	 public String noticeCUDAjax(@RequestParam HashMap<String, String> params) throws Throwable{
		 ObjectMapper mapper = new ObjectMapper(); // jackson 객체
		 
		 Map<String, Object> modelMap = new HashMap<String, Object>();
		 
		 String msg = "success";
		 
		 try {
			 int cnt = 0;
			 switch (params.get("gbn")) {
			case "c":
				cnt = noticeiService.writeNotice(params);
				break;
			
			case"u":
				cnt = noticeiService.updateNotice(params);
				break;
			case"d":
				cnt = noticeiService.delNotice(params);
				break;
			}
			 
			if (cnt == 0) {
				msg = "failed";
			}
		} catch (Exception e) {
			e.printStackTrace();
			
			msg = "erorr";
		}
		 
		 
		 modelMap.put("msg", msg);
		 
		 return mapper.writeValueAsString(modelMap);
	 		}
	
}
