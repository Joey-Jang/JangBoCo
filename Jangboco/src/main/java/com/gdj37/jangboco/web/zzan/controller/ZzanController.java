package com.gdj37.jangboco.web.zzan.controller;

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
import com.gdj37.jangboco.web.zzan.service.IZzanService;

@Controller
public class ZzanController {
	@Autowired
	public IZzanService iZzanService;
	
	@RequestMapping(value="/zzanMain")
	public ModelAndView zzanMain(@RequestParam HashMap<String,String> params,
			ModelAndView mav) throws Throwable {
		int homeFlag = 0;
		int menuIdx = 0;
		int subMenuIdx = 0;
		int sessnMemberNo = 2;
		mav.addObject("sessnMemberNo", sessnMemberNo);

		mav.addObject("homeFlag", homeFlag);
		mav.addObject("menuIdx", menuIdx);
		mav.addObject("subMenuIdx", subMenuIdx);
		
		List<HashMap<String, String>> list = iZzanService.getMarketList(params);
		
		mav.addObject("list", list);
		
		mav.setViewName("jangboco/zzan/zzanMain");
		
		return mav;
	}
	
	
	@RequestMapping(value="/MarketListAjax", method = RequestMethod.POST,
			produces = "text/json;charset=UTF-8")
	@ResponseBody //Spring에게 돌려주는 내용이 이미 완성된 view임을 제시
				//(단계를 스킵한다고 생각하면됨, viewresolver랑 view를 거치지않겠다)
	public String MarketListAjax(@RequestParam HashMap<String,String> params) throws Throwable{
		//modelandview 필요없음, string보낼거니까
		ObjectMapper mapper = new ObjectMapper();//jackson 객체 : 여러 형태를 담을 수 있고, 그것을 문자열로 바꿀수있음 
		
		Map<String, Object> modelMap = new HashMap<String, Object>(); //데이터를 담을 map
	
		//리스트 조회
		List<HashMap<String,String>> list = iZzanService.getMarketList(params);
		
		//데이터 담기
		modelMap.put("list", list);
		
		//데이터를 문자열화
		return mapper.writeValueAsString(modelMap);
		
	}
	
	@RequestMapping(value="/ItemListAjax", method = RequestMethod.POST,
			produces = "text/json;charset=UTF-8")
	@ResponseBody //Spring에게 돌려주는 내용이 이미 완성된 view임을 제시
				//(단계를 스킵한다고 생각하면됨, viewresolver랑 view를 거치지않겠다)
	public String ItemListAjax(@RequestParam HashMap<String,String> params) throws Throwable{
		//modelandview 필요없음, string보낼거니까
		ObjectMapper mapper = new ObjectMapper();//jackson 객체 : 여러 형태를 담을 수 있고, 그것을 문자열로 바꿀수있음 
		
		Map<String, Object> modelMap = new HashMap<String, Object>(); //데이터를 담을 map
	
		//리스트 조회
		List<HashMap<String,String>> list = iZzanService.getItemList(params);
		
		//데이터 담기
		modelMap.put("list", list);
		
		//데이터를 문자열화
		return mapper.writeValueAsString(modelMap);
		
	}
	
	@RequestMapping(value="/ItemListPrsntAjax", method = RequestMethod.POST,
			produces = "text/json;charset=UTF-8")
	@ResponseBody //Spring에게 돌려주는 내용이 이미 완성된 view임을 제시
				//(단계를 스킵한다고 생각하면됨, viewresolver랑 view를 거치지않겠다)
	public String ItemListPrsntAjax(@RequestParam HashMap<String,String> params) throws Throwable{
		//modelandview 필요없음, string보낼거니까
		ObjectMapper mapper = new ObjectMapper();//jackson 객체 : 여러 형태를 담을 수 있고, 그것을 문자열로 바꿀수있음 
		
		Map<String, Object> modelMap = new HashMap<String, Object>(); //데이터를 담을 map
	
		//리스트 조회
		List<HashMap<String,String>> list = iZzanService.getItemList(params);
		
		//데이터 담기
		modelMap.put("list", list);
		
		//데이터를 문자열화
		return mapper.writeValueAsString(modelMap);
		
	}
	
	@RequestMapping(value = "/zzanDataTest")
	public ModelAndView testMList(@RequestParam HashMap<String, String> params,
								ModelAndView mav) throws Throwable {
	
		// 목록데이터 취득
		List<HashMap<String, String>> list = iZzanService.getMarketList(params);
		
		mav.addObject("list", list);
		
		mav.setViewName("jangboco/zzan/zzanDataTest");
		
		return mav;
	}
	
	@RequestMapping(value="/zzanCluster")
	public ModelAndView zzanCluster(@RequestParam HashMap<String,String> params,
			ModelAndView mav) throws Throwable {
		// 목록데이터 취득
		List<HashMap<String, String>> list = iZzanService.getMarketList(params);
				
		mav.addObject("list", list);
				
		mav.setViewName("jangboco/zzan/zzanCluster");
		
		return mav;
	}
	
	
}
