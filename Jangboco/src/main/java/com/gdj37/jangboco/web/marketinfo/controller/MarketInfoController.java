package com.gdj37.jangboco.web.marketinfo.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
import com.gdj37.jangboco.web.marketinfo.service.IMarketInfoService;

@Controller
public class MarketInfoController {
	@Autowired
	public IMarketInfoService iMarketInfoService;
	
	@Autowired
	public IPagingService iPagingService;
	
	@RequestMapping(value="/marketInfo")
	public ModelAndView marketDtl(@RequestParam HashMap<String, String> params,							
							ModelAndView mav) throws Throwable {
		HashMap<String, String> marketInfo = null;
		List<HashMap<String, String>> marketList = null;
		// marketNo 테스트 데이터
		String marketNo = "49";
		params.put("marketNo",marketNo);
		mav.addObject("marketNo",marketNo);
		
		// marketMemberNo 테스트 데이터
		String marketMemberNo = "9";
		mav.addObject("marketMemberNo",marketMemberNo);
		params.put("marketMemberNo", marketMemberNo);
		
		if(params.get("marketMemberNo")!= null) {			
			marketInfo = iMarketInfoService.getMarketInfoU(params);
		} else {
			marketInfo = iMarketInfoService.getMarketInfoBU(params);
		}		
		
		String itemsChoiceNo = "99";
		if(params.get("itemsChoiceNo")!= null) {
			itemsChoiceNo = params.get("itemsChoiceNo");
		}
		mav.addObject("itemsChoiceNo",itemsChoiceNo);
		
		String page="1";
		
		if(params.get("page")!= null) {
			page= params.get("page");
		}	
		
		mav.addObject("marketInfo",marketInfo);
		mav.addObject("page",page);
		
		mav.setViewName("jangboco/pricecompr/marketInfo");		
		
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
			List<HashMap<String, String>> list = null;
			if(params.get("itemsChoiceNo") == "") {
				list = iMarketInfoService.getItemsList(params);				
			} else {
				list = iMarketInfoService.getItemsListNoChoice(params);
				list.add(0,iMarketInfoService.getItemsListChoice(params));				
			}
			
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
			
			PagingBean pb = iPagingService.getPagingBean(page, cnt,7,5);
			
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
	
	
	
}
