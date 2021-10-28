package com.gdj37.jangboco.web.priceschart.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.gdj37.jangboco.web.priceschart.service.IPricesChartService;

@Controller
public class PricesChartController {
	@Autowired
	public IPricesChartService iPricesChartService;
	
	
	// 차트 페이지
	@RequestMapping(value="/pricesChart")
	public ModelAndView pricesChart(ModelAndView mav){		
		
		int homeFlag = 0;
	    int menuIdx = 0;
	    int subMenuIdx = 2;
	    mav.addObject("homeFlag", homeFlag);
	    mav.addObject("menuIdx", menuIdx);
	    mav.addObject("subMenuIdx", subMenuIdx);
	    
	    mav.setViewName("/jangboco/priceschart/pricesChart");		
		
	    return mav;
	}		
	
	
	// 선형그래프 차트 ajax
	@RequestMapping(value="/lineChartAjax", method= RequestMethod.POST,
			produces = "text/json;charset=UTF-8" )
	@ResponseBody
	public String lineChartAjax(@RequestParam HashMap<String, String> params) 
				throws Throwable{
		ObjectMapper mapper = new ObjectMapper();
		
		Map<String, Object> modelMap = new HashMap<String, Object>();		
		
		try {
			 
			List<HashMap<String, String>> list = iPricesChartService.getLineDataList(params);
			List<String> dateList = iPricesChartService.getDateList(params);
			List<HashMap<String, String>> itemNameList = iPricesChartService.getItemNameList(params);
			modelMap.put("list", list);
			modelMap.put("dateList", dateList);
			modelMap.put("itemNameList", itemNameList);
		
		} catch (Exception e) {
			 e.printStackTrace();
		}
		
		return mapper.writeValueAsString(modelMap);		
	}
	
	@RequestMapping(value="/disctChartAjax", method= RequestMethod.POST,
			produces = "text/json;charset=UTF-8" )
	@ResponseBody
	public String disctChartAjax(@RequestParam HashMap<String, String> params) 
				throws Throwable{
		ObjectMapper mapper = new ObjectMapper();
		
		Map<String, Object> modelMap = new HashMap<String, Object>();		
		
		try {			
			List<HashMap<String, String>> list = iPricesChartService.getDisctDataList(params);			
			modelMap.put("list", list);
			
		} catch (Exception e) {
			 e.printStackTrace();
		}
		
		return mapper.writeValueAsString(modelMap);		
	}
	
	@RequestMapping(value="/disctItemsChoiceAjax", method= RequestMethod.POST,
			produces = "text/json;charset=UTF-8" )
	@ResponseBody
	public String disctItemsChoiceAjax(@RequestParam HashMap<String, String> params) 
				throws Throwable{
		ObjectMapper mapper = new ObjectMapper();
		
		Map<String, Object> modelMap = new HashMap<String, Object>();		
		
		try {		
			List<HashMap<String, String>> list = iPricesChartService.getDisctItemsList(params);			
			modelMap.put("list", list);
			
		} catch (Exception e) {
			 e.printStackTrace();
		}
		
		return mapper.writeValueAsString(modelMap);		
	}
	
	@RequestMapping(value="/lineItemsChoiceAjax", method= RequestMethod.POST,
			produces = "text/json;charset=UTF-8" )
	@ResponseBody
	public String lineItemsChoiceAjax(@RequestParam HashMap<String, String> params) 
				throws Throwable{
		ObjectMapper mapper = new ObjectMapper();
		
		Map<String, Object> modelMap = new HashMap<String, Object>();		
		
		try {		
			List<HashMap<String, String>> list = iPricesChartService.getDisctItemsList(params);			
			modelMap.put("list", list);
			
		} catch (Exception e) {
			 e.printStackTrace();
		}
		
		return mapper.writeValueAsString(modelMap);		
	}
	
	@RequestMapping(value="/categoryChartAjax", method= RequestMethod.POST,
			produces = "text/json;charset=UTF-8" )
	@ResponseBody
	public String categoryChartAjax(@RequestParam HashMap<String, String> params) 
				throws Throwable{
		ObjectMapper mapper = new ObjectMapper();
		
		Map<String, Object> modelMap = new HashMap<String, Object>();
		String itemsName = params.get("itemsName");
		System.out.println(params.get("itemsName"));
		if(itemsName != null && itemsName != "") {			
			itemsName= itemsName.replace(',', '|');
		}
		params.put("itemsName", itemsName);
		
		
		try {		
			List<HashMap<String, String>> list = iPricesChartService.getCategoryChartData(params);			
			modelMap.put("list", list);
			
		} catch (Exception e) {
			 e.printStackTrace();
		}
		
		return mapper.writeValueAsString(modelMap);		
	}
}
