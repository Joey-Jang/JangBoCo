package com.gdj37.jangboco.web.intgrevent.controller;

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
import com.gdj37.jangboco.web.intgrevent.service.IIntgrEventService;



@Controller
public class IntgrEventController {
	@Autowired
	public IIntgrEventService iIntgrEventService;
	
	@Autowired
	public IPagingService iPagingService; 
	
	// 지역별 행사소식 게시판 
	@RequestMapping(value="/intgrEventList")
	public ModelAndView intgrEventList(@RequestParam HashMap<String, String> params,
							ModelAndView mav) throws Throwable{
		String page= "1";
		
		if(params.get("page")!=null) {
			page = params.get("page");
		}
		
		String disctNo="";
		String disctName = "";				
		if(params.get("disctNo") != null) {
			disctNo= params.get("disctNo");
			disctName = iIntgrEventService.getDisctName(params);
		}
		
		
		mav.addObject("disctNo",disctNo);
		mav.addObject("disctName",disctName);
		mav.addObject("page", page);
		
		mav.setViewName("jangboco/intgrevent/intgrEventList");
		
		return mav;		
	}
	
	
	// 지역별 행사소식 목록
	@RequestMapping(value="/intgrEventListAjax", method= RequestMethod.POST,
			produces = "text/json;charset=UTF-8" )
	@ResponseBody
	public String intgrEventListAjax(@RequestParam HashMap<String, String> params) 
				throws Throwable{
		ObjectMapper mapper = new ObjectMapper();
		
		Map<String, Object> modelMap = new HashMap<String, Object>();
		
		try {			
			int page = Integer.parseInt(params.get("page"));
			
			int cnt = iIntgrEventService.getEventCnt(params);
			
			PagingBean pb = iPagingService.getPagingBean(page, cnt);
			
			params.put("startCnt", Integer.toString(pb.getStartCount()));
			params.put("endCnt", Integer.toString(pb.getEndCount()));
			
			String disctNo ="";
			if(params.get("disctNo") == null || params.get("disctNo") == "" ) {
				disctNo = iIntgrEventService.getDisctNo(params);
				params.put("disctNo", disctNo);				
			}
			
			List<HashMap<String, String>> normalList = iIntgrEventService.getEventNormalList(params);
			
			List<HashMap<String, String>> bestList= iIntgrEventService.getEventBestList(params);
			
			modelMap.put("normalList", normalList);
			modelMap.put("bestList", bestList);
			modelMap.put("pb", pb);			
		} catch (Exception e) {
			 e.printStackTrace();
		}
		
		return mapper.writeValueAsString(modelMap); 
	}
	
	// 행사소식 상세보기
	@RequestMapping(value="/intgrEventDtl")
	public ModelAndView intgrEventDtl( HttpServletRequest request, HttpServletResponse response,
									 @RequestParam HashMap<String, String> params,
									 ModelAndView mav) throws Throwable {
		String eventNo = params.get("eventNo");
		if(eventNo !=null) {			
			// 조회수 중복 방지를 위한 쿠키
			
			Cookie comprCookie = null; // 비교를 위한 쿠키 선언
			
			Cookie[] cookies = request.getCookies(); // 클라이언트의 쿠키를 가져옴.
			
			if(cookies != null) { 
				for(Cookie cookie : cookies) { 
					// for문으로 가져온 쿠키들의 이름을 비교
					// 클라이언트의 쿠키 중 해당 게시글을 읽었다면
					// 비교쿠키에 해당 쿠키값을 넣어준다.
					if(cookie.getName().equals("eventView"+eventNo)) {						
						comprCookie = cookie;
					}
				}
			}
			
			if(comprCookie ==null) {
				// 비교할 쿠키가 널이라면 해당 게시글을 읽은 이력이 없기 때문에
				// 새로운 쿠키를 eventView + eventNo 형식의 이름과, [ 행사글번호 ]를 저장. 
				Cookie newCookie = new Cookie("eventView"+eventNo,"["+ eventNo +"]");
				
				newCookie.setMaxAge(60*60*1);
				
				// 새로 생성한 쿠키를 클라이언트의 브라우저저장소에 추가
				response.addCookie(newCookie);
				
				// 비교할 쿠키가 널이었기 때문에 조회수를 올려준다.
				int result = iIntgrEventService.updateEventHit(params);				
			}
			
			HashMap<String, String> data = iIntgrEventService.getEventDtl(params);
			
			mav.addObject("data",data);
			
			mav.setViewName("jangboco/intgrevent/intgrEventDtl");				
		} else {
			mav.setViewName("redirect:/intgrEventList");
		}
		
		return mav;
	}
}
