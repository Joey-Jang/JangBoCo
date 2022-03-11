package com.gdj37.jangboco.web.itemsinfo.controller;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.URL;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.json.simple.JSONArray;
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
import com.gdj37.jangboco.common.bean.PagingBean;
import com.gdj37.jangboco.common.service.IPagingService;
import com.gdj37.jangboco.web.itemsinfo.service.IItemsInfoService;
import com.gdj37.jangboco.web.priceschart.service.IPricesChartService;
import com.gdj37.jangboco.web.recipeapi.service.IRecipeService;



@Controller
public class ItemsInfoController {
	@Autowired
	public IItemsInfoService iItemsInfoService;
	@Autowired
	public IPricesChartService iPricesChartService;
	
	@Autowired
	public IPagingService iPagingService; 
	
	@Autowired
	public IRecipeService iRecipeService;
	
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
		

		String page= "1";
		
		if(params.get("page")!=null) {
			page = params.get("page");
		}		
		
		mav.addObject("page", page);
		
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
			System.out.println("=========================");
			System.out.println(list.get("ITEMS_NAME"));
			System.out.println("=========================");
			String str = list.get("ITEMS_NAME");
			String matrlName = str;
			if(str.indexOf("(") != -1 ) {
				matrlName = str.substring(0, str.indexOf("("));				
			}
			System.out.println(matrlName);
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
			modelMap.put("matrlName", matrlName);
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
//			URL url = new URL("http://openapi.foodsafetykorea.go.kr/api/"+ key +
//								"/COOKRCP01/json/1/1000/RCP_PARTS_DTLS="+ matrlName);
			URL url = new URL("http://localhost:8090/Jangboco/resources/reciJson/fork_reci.json");
			
			BufferedReader bf;
			bf = new BufferedReader(new InputStreamReader(url.openStream(),"UTF-8"));
			
			result = bf.readLine();
			// System.out.println(result);
			
			JSONParser jsonParser = new JSONParser();
			JSONObject jsonObject = (JSONObject)jsonParser.parse(result);
			JSONObject cookrcp01 = (JSONObject)jsonObject.get("COOKRCP01");
			// System.out.println(cookrcp01);

			int totalCnt = Integer.parseInt((String)cookrcp01.get("total_count"));
			System.out.println(totalCnt);			

			JSONArray recipeList = (JSONArray)cookrcp01.get("row");
			
			int page = Integer.parseInt(params.get("page"));
			PagingBean pb = iPagingService.getPagingBean(page, totalCnt,2,5);				
			
			for(int i = 0; i<recipeList.size(); i++) {
				String artclNo = ""+(recipeList.size()-i);				
				
				JSONObject recipeRow = (JSONObject)recipeList.get(i);
				
				recipeRow.put("artclNo", artclNo);
			}		
			
			modelMap.put("pb", pb);			
			modelMap.put("recipeList", recipeList);
			
		} catch (Exception e) {
			 e.printStackTrace();
		}
		
		return mapper.writeValueAsString(modelMap); 
	}	
	
	@RequestMapping(value="/recipeDtlAjax", method= RequestMethod.POST,
			produces = "text/json;charset=UTF-8" )
	@ResponseBody
	public String recipeDtlAjax(@RequestParam HashMap<String, String> params) 
				throws Throwable{
		ObjectMapper mapper = new ObjectMapper();
		
		Map<String, Object> modelMap = new HashMap<String, Object>();		
		
		try {
			HashMap<String, String> recipe = iRecipeService.getRecipeDtl(params);
			
			modelMap.put("recipe", recipe);
			
		} catch (Exception e) {
			e.printStackTrace();
		}		
		
		return mapper.writeValueAsString(modelMap); 
	}
	
	@RequestMapping(value="/itemsChoiceAjax", method= RequestMethod.POST,
			produces = "text/json;charset=UTF-8" )
	@ResponseBody
	public String itemsChoiceAjax(@RequestParam HashMap<String, String> params) 
				throws Throwable{
		ObjectMapper mapper = new ObjectMapper();
		
		Map<String, Object> modelMap = new HashMap<String, Object>();	
		System.out.println(params);
		String itemsName = params.get("itemsName");
		System.out.println(params.get("itemsName"));
		
		if(itemsName != null && itemsName != "") {			
			itemsName= itemsName.replace(',', '|');
		}
		params.put("itemsName", itemsName);
		
		try {
			
			List<HashMap<String, String>> list = iItemsInfoService.getItemsChoiceList(params);
			
			modelMap.put("list", list);
			
		} catch (Exception e) {
			e.printStackTrace();
		}		
		
		return mapper.writeValueAsString(modelMap); 
	}
}
