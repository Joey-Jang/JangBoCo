package com.gdj37.jangboco.web.marketinfo.controller;

import java.util.ArrayList;
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
import com.gdj37.jangboco.web.marketinfo.service.IMarketInfoService;

@Controller
public class MarketInfoController {
	@Autowired
	public IMarketInfoService iMarketInfoService;
	
	@Autowired
	public IIntgrEventService iIntgrEventService;
	
	@Autowired
	public IPagingService iPagingService;
	
	@RequestMapping(value="/marketInfo")
	public ModelAndView marketDtl(@RequestParam HashMap<String, String> params,							
							ModelAndView mav) throws Throwable {
		HashMap<String, String> marketInfo = null;
		List<HashMap<String, String>> marketList = null;
		if(params.get("market_no") != null && params.get("market_no") != null) {			
			// marketNo 데이터
			String marketNo = "";		
			marketNo = params.get("market_no");
			System.out.println("=======================");
			System.out.println(marketNo);
			System.out.println("=======================");
			params.put("marketNo",marketNo);		
			mav.addObject("marketNo",marketNo);
			
			// marketMemberNo 데이터
			String marketMemberNo = "";
			marketMemberNo = params.get("market_member_no");
			System.out.println("=======================");
			System.out.println(marketMemberNo);
			System.out.println(params.get("market_member_no"));
			System.out.println("=======================");
			params.put("marketMemberNo", marketMemberNo);
			mav.addObject("marketMemberNo",marketMemberNo);		
			
			if(params.get("marketMemberNo")!= null && params.get("marketMemberNo")!= "") {
				System.out.println("회원 데이터 조회");
				marketInfo = iMarketInfoService.getMarketInfoU(params);
			} else {
				System.out.println("비회원 데이터 조회");
				marketInfo = iMarketInfoService.getMarketInfoBU(params);
			}		
			
			String itemsChoiceNo = "";
			if(params.get("items_choice_no")!= null) {
				itemsChoiceNo = params.get("items_choice_no");
			}
			mav.addObject("itemsChoiceNo",itemsChoiceNo);
			
			String page="1";
			
			if(params.get("page")!= null) {
				page= params.get("page");
			}
			
			mav.addObject("marketInfo",marketInfo);
			mav.addObject("page",page);
			
			mav.setViewName("jangboco/pricecompr/marketInfo");	
		} else {			
			mav.setViewName("redirect:/home");	
		}
		
		return mav;
	}
	
	
	// 마켓 품목 목록
	@RequestMapping(value="/marketItemsListAjax", method= RequestMethod.POST,
			produces = "text/json;charset=UTF-8" )
	@ResponseBody
	public String marketItemsListAjax(@RequestParam HashMap<String, String> params) 
				throws Throwable{
		ObjectMapper mapper = new ObjectMapper();
		
		Map<String, Object> modelMap = new HashMap<String, Object>();
		
		try {
			System.out.println("=======================");
			System.out.println(params.get("marketNo"));
			System.out.println("마켓번호 조회");
			System.out.println("=======================");
			
			List<HashMap<String, String>> list = null;
			if(params.get("itemsChoiceNo") == "") {
				list = iMarketInfoService.getItemsList(params);				
			} else {
				list = iMarketInfoService.getItemsListNoChoice(params);
				list.add(0,iMarketInfoService.getItemsListChoice(params));				
			}
			System.out.println("=======================");
			System.out.println(list);
			System.out.println("리스트 조회");
			System.out.println("=======================");
			modelMap.put("list", list);
		} catch (Exception e) {
			 e.printStackTrace();
		}
		
		return mapper.writeValueAsString(modelMap); 
	}
	
	// 마켓 상세 행사 목록
	@RequestMapping(value="/marketInfoEventAjax", method= RequestMethod.POST,
			produces = "text/json;charset=UTF-8" )
	@ResponseBody
	public String marketInfoEventAjax(@RequestParam HashMap<String, String> params) 
				throws Throwable{
		ObjectMapper mapper = new ObjectMapper();
		
		Map<String, Object> modelMap = new HashMap<String, Object>();
		
		
		try {
			
			int page = Integer.parseInt(params.get("page"));
			
			int cnt = iMarketInfoService.getMarketEventCnt(params);
			
			PagingBean pb = iPagingService.getPagingBean(page, cnt,5,5);
			
			params.put("startCnt", Integer.toString(pb.getStartCount()));
			params.put("endCnt", Integer.toString(pb.getEndCount()));
			
			List<HashMap<String, String>> list = iMarketInfoService.getEventList(params);			
		
			
			modelMap.put("list", list);
			
			modelMap.put("pb", pb);			
		} catch (Exception e) {
			 e.printStackTrace();
		}
		
		return mapper.writeValueAsString(modelMap); 
	}	
	
	@RequestMapping(value="/eventDtlModal")
	public ModelAndView eventDtlModal(@RequestParam HashMap<String, String> params,
			ModelAndView mav) {
		
		mav.setViewName("jangboco/pricecompr/eventDtlModal");
		
		return mav;
	}
	
	// 행사 모달
		@RequestMapping(value="/eventModalAjax", method= RequestMethod.POST,
				produces = "text/json;charset=UTF-8" )
		@ResponseBody
		public String eventModalAjax( HttpServletRequest request, HttpServletResponse response,
				@RequestParam HashMap<String, String> params) 
					throws Throwable{
			ObjectMapper mapper = new ObjectMapper();
			
			Map<String, Object> modelMap = new HashMap<String, Object>();
			
			String eventNo = params.get("eventNo");
			try {
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
				
				HashMap<String, String> data = iMarketInfoService.getEventData(params);		
			
				
				modelMap.put("data", data);							
			} catch (Exception e) {
				 e.printStackTrace();
			}
			
			return mapper.writeValueAsString(modelMap); 
		}
}
