package com.gdj37.jangboco.web.itemsinfo.controller;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.URL;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.gdj37.jangboco.web.itemsinfo.service.IItemsInfoService;
import com.gdj37.jangboco.web.priceschart.service.IPricesChartService;



@Controller
public class ItemsInfoController {
	@Autowired
	public IItemsInfoService iItemsInfoService;
	@Autowired
	public IPricesChartService iPricesChartService;
	
	@RequestMapping(value="/itemsInfo")
	public ModelAndView itemsInfo(@RequestParam HashMap<String, String> params,
			ModelAndView mav) {
		
		String itemsNo = "99";
		if(params.get("itemsNo") != null) {
			itemsNo = params.get("itemsNo"); 
		}		
		
		String matrlName ="돼지고기";
		
		mav.addObject("itemsNo",itemsNo);
		mav.addObject("matrlName",matrlName);
		
		int homeFlag = 0;
	    int menuIdx = 0;
	    int subMenuIdx = 1;
	    mav.addObject("homeFlag", homeFlag);
	    mav.addObject("menuIdx", menuIdx);
	    mav.addObject("subMenuIdx", subMenuIdx);
		
		mav.setViewName("jangboco/itemsinfo/itemsInfo");
		
		return mav;
	}	
	
	@RequestMapping(value="/itemsInfoAjax", method= RequestMethod.POST,
			produces = "text/json;charset=UTF-8" )
	@ResponseBody
	public String itemsInfoAjax(@RequestParam HashMap<String, String> params) 
				throws Throwable{
		ObjectMapper mapper = new ObjectMapper();
		
		Map<String, Object> modelMap = new HashMap<String, Object>();
		
		String startDate = "21-01-01";
		String endDate = "21-12-31";
		
		params.put("startDate", startDate);
		params.put("endDate", endDate);
		
		
		try {
			HashMap<String, String> list = iItemsInfoService.getItemsInfo(params);
			
			// 선형 차트 데이터
			List<HashMap<String, String>> lineChartlist = iPricesChartService.getLineDataList(params);
			List<String> dateList = iPricesChartService.getDateList(params);
			List<HashMap<String, String>> itemNameList = iPricesChartService.getItemNameList(params);
			// 지역구별 차트 데이터
			List<HashMap<String, String>> disctChartList = iPricesChartService.getDisctDataList(params);			
			
			modelMap.put("list", list);
			modelMap.put("lineChartlist", lineChartlist);
			modelMap.put("dateList", dateList);
			modelMap.put("itemNameList", itemNameList);
			modelMap.put("disctChartList", disctChartList);
		} catch (Exception e) {
			 e.printStackTrace();
		}
		
		return mapper.writeValueAsString(modelMap); 
	}
	
	
	@RequestMapping(value="/recipeAjax", method= RequestMethod.POST,
			produces = "text/json;charset=UTF-8" )
	@ResponseBody
	public String recipeAjax(@RequestParam HashMap<String, String> params) 
				throws Throwable{
		ObjectMapper mapper = new ObjectMapper();
		
		Map<String, Object> modelMap = new HashMap<String, Object>();		
		
		String key = "121c409444094fdea525";
		
		String matrlName = params.get("matrlName");
		
		String result = "";
		
		try {
			URL url = new URL("http://openapi.foodsafetykorea.go.kr/api/"+ key +
								"/COOKRCP01/json/1/1/RCP_PARTS_DTLS="+ matrlName);
			
			BufferedReader bf;
			bf = new BufferedReader(new InputStreamReader(url.openStream(),"UTF-8"));
			
			result = bf.readLine();
			System.out.println(result);
			System.out.println("====================");
			
			JSONParser jsonParser = new JSONParser();
			JSONObject jsonObject = (JSONObject)jsonParser.parse(result);
			JSONObject cookrcp01 = (JSONObject)jsonObject.get("COOKRCP01");
			System.out.println(cookrcp01);
			System.out.println("====================");
			String totalCnt = (String)cookrcp01.get("total_count");
			System.out.println(totalCnt);
			System.out.println("====================");
//			JSONObject cookrcp01 = (JSONObject)cookrcp01.get("total_count");
//			JSONObject cookrcp01 = (JSONObject)cookrcp01.get("row");
			
			
		} catch (Exception e) {
			 e.printStackTrace();
		}
		
		return mapper.writeValueAsString(modelMap); 
	}
}
